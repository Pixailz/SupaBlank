# SRCS
SRC_C_MANDATORY		:= utils/utils.1.c								\
					   utils/utils.2.c								\
					   utils/utils.3.c								\
					   utils/utils.4.c								\
					   main.c

SRC_C_BONUS			:= utils/utils.1.c								\
					   utils/utils.2.c								\
					   utils/utils.3.c								\
					   utils/utils.4.c								\
					   main.c

ifeq ($(BONUS),1)
SRC_DIR_F			:= $(SRC_DIR)/bonus
TARGET				:= $(TARGET_BONUS)
else
SRC_DIR_F			:= $(SRC_DIR)/mandatory
endif

# OBJ
ifeq ($(BONUS),1)
SRC_C				:= $(addprefix $(SRC_DIR_F)/,$(SRC_C_BONUS))
OBJ_C				:= $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRC_C:%.c=%.o))
else
SRC_C				:= $(addprefix $(SRC_DIR_F)/,$(SRC_C_MANDATORY))
OBJ_C				:= $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRC_C:%.c=%.o))
endif

OBJ_C_NB			:= $(words $(OBJ_C))
OBJ_C_NB_LEN		:= $(shell printf "$(OBJ_C_NB)" | wc -c)
