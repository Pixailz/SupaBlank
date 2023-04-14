# include
include mk/config.mk			# base config
include mk/pb.mk				# ui thing, progress bar etc
include mk/srcs.mk				# srcs.mk

ifeq ($(DEBUG),1)
CFLAGS							+= -g3
.SHELLFLAGS						+= -x
else
CFLAGS							+= -Werror
endif


# rule
$(call PB_INIT)
## config
.SILENT:						clean fclean init_pb $(TARGET) $(OBJ_C)
.PHONY:							debug init_pb

## target
$(TARGET):						$(OBJ_C)
> $(call PB_DONE)
> $(call P_INF,Creating $(R)$(TARGET)$(RST))
> gcc $(CFLAGS) -o $(TARGET) $(OBJ_C)
> $(call PB_TARGET_DONE)

## objs
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
# $(<)		: dependencies
# $(@)		: full target
# $(@D)		: dir target
$(OBJ_C):						$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c
> $(call MKDIR,$(@D))
> $(call PB_PRINT,$(@))
> gcc $(CFLAGS) -o $@ -c $<

## utils
### DEBUG
debug:
> $(call PB_INIT,$(OBJ_C))

### CLEAN
clean:
> $(call P_FAI,Removing $(OBJ_DIR))
> rm -rf $(OBJ_DIR)

fclean:							clean
> $(call P_FAI,Removing $(TARGET))
> rm -rf $(TARGET)

re:								fclean $(TARGET)

