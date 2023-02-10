TARGET							:= prog
CFLAGS							:= -Wall -Wextra -g3
PRINTF							:= @printf

SRC_DIR							:= src
OBJ_DIR							:= obj
INC_DIR							:= .

CFLAGS							+= -I$(INC_DIR)

# SRC_C							:= utils.1.c			\
# 								   utils.2.c			\
# 								   utils.3.c			\
# 								   utils.4.c			\
# 								   main.c

SRC_C							:= utils.1.c			\
								   main.c

OBJ_C							:= $(addprefix $(OBJ_DIR)/,$(SRC_C:%.c=%.o))
SRC_C							:= $(addprefix $(SRC_DIR)/,$(SRC_C))

PB_STEP_NB						:= $(words $(OBJ_C))
PB_STEP_ID						:= 0

PB_LENGTH						:= 30
PB_CHAR_EMPTY					:= "\ "
PB_CHAR_FULL					:= "="
PB_CHAR_HEAD					:= >

ANSI_ESC						:= \033

define pg_obj
	$(PRINTF) "$(ANSI_ESC)[2K"
	$(PRINTF) "$(ANSI_ESC)[1E"
	$(PRINTF) "$(ANSI_ESC)[2K"
	$(PRINTF) "$(ANSI_ESC)[1F"

	$(PRINTF) "(%d/%d) " $(shell echo $$(($(PB_STEP_ID) + 1))) $(PB_STEP_NB)
	$(PRINTF) "$1\n"

	$(eval CURRENT_POURCENT:=$(shell echo $$((($(PB_STEP_ID) * 100) / $(PB_STEP_NB)))))
	$(PRINTF) "%s%%" $(CURRENT_POURCENT)
	$(PRINTF) " %.0s" $(shell seq 1 $$((4 - `echo -n $(CURRENT_POURCENT) | wc -m`)))

	$(if $(filter-out $(CURRENT_POURCENT),0),$(eval PB_FULL := $(shell printf "$(PB_CHAR_FULL)%.0s" $(shell echo `seq 2 $$(( $(CURRENT_POURCENT) * $(PB_LENGTH) / 100))` ))))

	$(eval PB_EMPTY:=$(shell printf "${PG_EMPTY}%.0s" $(shell echo `seq 2 $$((PG_LEN - `echo $(PB_FULL) | wc -m`))`) ))
	$(PRINTF) "[$(PB_FULL)$(PB_CHAR_HEAD)$(PB_EMPTY)]\n"
	$(PRINTF) "$(ANSI_ESC)[2F"
	$(eval PB_STEP_ID=$(shell echo $$(($(PB_STEP_ID)+1))))

endef


.SILENT:						$(OBJ_C)
.PHONY:							deactivate_cursor
.PHONY:							activate_cursor
.PHONY:							setup_obj

$(TARGET):						$(OBJ_C)
	gcc $(CFLAGS) -o $(TARGET) $(OBJ_C)

deactivate_cursor:
	$(PRINTF) "$(ANSI_ESC)[?25l"

activate_cursor:
	$(PRINTF) "$(ANSI_ESC)[?25h"

print_title_obj:
	$(PRINTF) "Creating objs\n"

$(OBJ_C):						$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c print_title_obj
	$(call pg_obj,$@)
	$(shell [ -d $(@D) ] || mkdir -p $(@D))
	gcc $(CFLAGS) -o $@ -c $<
	sleep 1

clean:
	rm -rf $(OBJ_DIR)

fclean:							clean
	rm -rf $(TARGET)

re:								fclean $(TARGET)

