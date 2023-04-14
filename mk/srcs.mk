# SRCS
SRC_C							:= utils/utils.1.c								\
								   utils/utils.2.c								\
								   utils/utils.3.c								\
								   utils/utils.4.c								\
								   main.c

# SRC_C							:= utils.1.c									\
# 								   main.c

OBJ_C							:= $(addprefix $(OBJ_DIR)/,$(SRC_C:%.c=%.o))
SRC_C							:= $(addprefix $(SRC_DIR)/,$(SRC_C))

OBJ_C_NB						:= $(words $(OBJ_C))
SRC_C_NB						:= $(words $(SRC_C))
