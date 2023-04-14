# BASE
TARGET			:= prog
CFLAGS			:= -Wall -Wextra

## SOME DIRS
SRC_DIR			:= src
OBJ_DIR			:= obj
INC_DIR			:= .
CFLAGS			+= -I$(INC_DIR)

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

## CURSOR
CU					:= "$(ESC)1F"
DL					:= "$(ESC)2K"
CUDL				:= "$(CU)$(DL)"

# ALIAS
## Timestamps function
GET_TS			= $(shell date +"%s%3N")
GET_ELAPSED		= $(shell echo $$(($(call GET_TS) - $(1))))

## print function
P_ANSI			= printf "%b" $(ESC)$(1);
P_INF			= printf "[%b] %b" $(I) "$(1)"; $(call PB_PRINT_ELAPSED)
P_WAR			= printf "[%b] %b" $(W) "$(1)"; $(call PB_PRINT_ELAPSED)
P_PAS			= printf "[%b] %b" $(P) "$(1)"; $(call PB_PRINT_ELAPSED)
P_FAI			= printf "[%b] %b" $(F) "$(1)"; $(call PB_PRINT_ELAPSED)
## ansi mov cursor
GOTO_COL			= $(call P_ANSI,$(1)G)

