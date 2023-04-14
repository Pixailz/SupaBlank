# BASE
TARGET			:= prog
TARGET_BONUS	:= prog_bonus
CC				:= gcc
CFLAGS			:= -Wall -Wextra
VERSION			:= 1.2.0

# BASH
SHELL			:= /usr/bin/bash
## set bash strict mode
.SHELLFLAGS		:= -eu -o pipefail -c

# Always use GNU Make.
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
## Use '>' to instead of tab.
.RECIPEPREFIX	= >

## PARSE_VARIABLE
## DEBUG
ifeq ($(DEBUG),1)
CFLAGS							+= -g3
# .SHELLFLAGS						+= -x
else
CFLAGS							+= -Werror
endif

### BONUS
ifeq ($(findstring bonus,$(MAKECMDGOALS)),bonus)
BONUS				:= 1
else
ifeq ($(findstring re_bonus,$(MAKECMDGOALS)),re_bonus)
BONUS				:= 1
else
ifeq ($(findstring run_bonus,$(MAKECMDGOALS)),run_bonus)
BONUS				:= 1
else
BONUS				:= 0
endif
endif
endif

## SOME DIRS
BIN_DIR			:= ./
SRC_DIR			:= src
LIB_DIR			:= lib
OBJ_DIR			:= obj
INC_TMP			:= inc \
				   $(LIB_DIR)/ft_libft/inc \
				   $(LIB_DIR)/minilibx-linux
INC_DIR			:= $(addprefix -I,$(INC_TMP))
CFLAGS			+= $(INC_DIR)

# LIB
LIBFT			:= $(LIB_DIR)/ft_libft/libft.a
MINI_LIBX		:= $(LIB_DIR)/minilibx-linux/libmlx_Linux.a
LDFLAGS			:= -Llib/minilibx-linux -L/usr/lib -lXext -lX11 -lm -lbsd -lz
LIBS			:= $(LIBFT) $(MINI_LIBX) $(LDFLAGS)


## check if $(1): is a dir and if $(1) not present, then make it
MKDIR			= \
if [ ! -d $(1) -a ! -f $(1) ]; then												\
	mkdir -p $(1)																;\
	$(call P_INF,Dir $(1) not found creating it)								\
	printf "\n"																	;\
fi

# ANSI
ESC					:= "\x1b["
## COLOR
RST					:= "$(ESC)0m"
R					:= "$(ESC)31m"
G					:= "$(ESC)32m"
Y					:= "$(ESC)33m"
B					:= "$(ESC)34m"
M					:= "$(ESC)35m"
C					:= "$(ESC)36m"
O					:= "$(ESC)38;5;214m"

### COMPOSITE
I					:= "$(B)i$(RST)"			# info
W					:= "$(O)⚠$(RST)"			# warning
P					:= "$(G)✓$(RST)"			# pass
F					:= "$(R)✗$(RST)"			# failed
ASCII_COLOR			:= "$(G)"

## CURSOR
CU					:= "$(ESC)1F"
DL					:= "$(ESC)2K"
CUDL				:= "$(CU)$(DL)"

# ALIAS
## Timestamps function
GET_TS				= $(shell date +"%s%3N")
GET_ELAPSED			= $(shell echo $$(($(call GET_TS) - $(1))))

## print function
P_ANSI				= printf "%b" $(ESC)$(1);
P_INF				= printf "[%b] %b" $(I) "$(1)"; $(call PB_PRINT_ELAPSED)
P_WAR				= printf "[%b] %b" $(W) "$(1)"; $(call PB_PRINT_ELAPSED)
P_PAS				= printf "[%b] %b" $(P) "$(1)"; $(call PB_PRINT_ELAPSED)
P_FAI				= printf "[%b] %b" $(F) "$(1)"; $(call PB_PRINT_ELAPSED)
## ansi mov cursor
GOTO_COL			= $(call P_ANSI,$(1)G)

# ASCII BANNER
define ASCII_BANNER
 ██████╗██╗   ██╗██████╗ ██████╗ ██████╗
██╔════╝██║   ██║██╔══██╗╚════██╗██╔══██╗
██║     ██║   ██║██████╔╝ █████╔╝██║  ██║
██║     ██║   ██║██╔══██╗ ╚═══██╗██║  ██║
╚██████╗╚██████╔╝██████╔╝██████╔╝██████╔╝
 ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝
endef
export ASCII_BANNER
