$(eval export MAIN=1) # compat with older Makefile

# include
include mk/config.mk			# base config
include mk/pb.mk				# ui thing, progress bar etc
include mk/srcs.mk				# srcs.mk

# rule
## config
.SILENT:

# .PHONY: setup print_obj_title print_obj_done all bonus ft_helper run run_bonus \
# debug re re_all re_bonus re_all

.PHONY: print_obj_title

.DEFAULT: all

all:			setup call_logo $(TARGET)

bonus:			setup call_logo $(TARGET)

### TARGETS
$(TARGET): $(LIBFT) $(MINI_LIBX) $(OBJ_C)
> $(call PB_DONE)
> $(call P_INF,Creating $(R)$(TARGET)$(RST))
> $(CC) $(CFLAGS) -o $@ $(OBJ_C) $(LIBS)
> $(call PB_TARGET_DONE)

## objs
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
# $(<)		: dependencies
# $(@)		: full target
# $(@D)		: dir target
$(OBJ_C):				$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c
> $(call MKDIR,$(@D))
> $(call PB_PRINT,$(@))
> gcc $(CFLAGS) -o $@ -c $<

### LIBS
$(LIBFT):
> make -C lib/ft_libft all

$(MINI_LIBX):
> make -C lib/minilibx-linux all

### DIRS
$(BIN_DIR):
> $(call MKDIR,$(BIN_DIR))

setup:					$(BIN_DIR)
> $(call PB_INIT)

call_logo:
> printf "%b%s%b\n" $(ASCII_COLOR) "$$ASCII_BANNER" "$(RST)"

ft_helper:
ifeq ($(DEBUG),1)
> @./scripts/ft_helper/ft_helper
endif

### RUN
run:					re
> ./$(TARGET) ./rsc/map/test.1.cub

run_bonus:				re_bonus
> ./$(TARGET_BONUS) ./rsc/map/test.1.cub

### DEBUG
debug:
> $(call PB_INIT,$(OBJ_C))

### CLEAN
clean:
> $(call P_FAI,Removing obj)
> $(shell find . -type f -name "*.o" -exec rm {} \;)

clean_all:				clean
> @make -C lib/ft_libft clean
> @make -C lib/minilibx-linux clean

fclean:							clean
> $(call P_FAI,Removing $(TARGET))
> rm -rf $(TARGET)

fclean_all:				fclean
> @make -C lib/ft_libft fclean
> @make -C lib/minilibx-linux clean

### RE
re:						setup call_logo fclean all
re_bonus:				setup call_logo fclean bonus

re_all:					re_lib re

re_lib:
> @make -C lib/ft_libft re
> @make -C lib/minilibx-linux re

