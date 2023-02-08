TARGET							:= prog
CFLAGS							:= -Wall -Wextra -g3
PRINTF							:= @printf

SRC_DIR							:= src
OBJ_DIR							:= obj
INC_DIR							:= .

CFLAGS							+= -I$(INC_DIR)

SRC_C							:= utils.1.c			\
								   utils.2.c			\
								   utils.3.c			\
								   utils.4.c			\
								   main.c

OBJ_C							:= $(addprefix $(OBJ_DIR)/,$(SRC_C:%.c=%.o))
SRC_C							:= $(addprefix $(SRC_DIR)/,$(SRC_C))



PROGRESS_BAR_LENGTH				:= 30
PROGRESS_BAR_EMPTY				:= ' '
PROGRESS_BAR_FULL				:= '='
#PROGRESS_BAR_HEAD				:= '>'

define print_obj
	
	$(PRINTF) "$1\n"
endef



.SILENT:						$(OBJ_C)



$(TARGET):						$(OBJ_C)

print_title_obj:
	$(PRINTF) "Creating objs\n"

$(OBJ_C):						$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c print_title_obj
	$(call print_obj,$@)
	$(shell sleep 0.5)
	$(shell [ -d $(@D) ] || mkdir -p $(@D))
	gcc $(CFLAGS) -o $@ -c $<

clean:
	rm -rf $(OBJ_DIR)

fclean:							clean
	rm -rf $(TARGET)

re:								fclean $(TARGET)

