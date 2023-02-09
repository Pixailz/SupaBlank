#!/bin/bash

FILES=(
	"rendering/raycast/vertical.o"
	"rendering/raycast/horizontal.o"
	"rendering/raycast/get_text.o"
	"rendering/raycast/cast.o"
	"rendering/utils.2.o"
	"rendering/texture/load.animated.o"
	"rendering/texture/load.o"
	"rendering/texture/get.highest.o"
	"rendering/texture/load.size.o"
	"rendering/move/dir.o"
	"rendering/move/angle.o"
	"rendering/move/keypress.o"
	"rendering/utils.1.o"
	"rendering/draw/frame.o"
	"rendering/draw/minimap/fov_ray_horizontal.o"
	"rendering/draw/minimap/player.o"
	"rendering/draw/minimap/fov_raycast.o"
	"rendering/draw/minimap/fov_draw.o"
	"rendering/draw/minimap/minimap.o"
	"rendering/draw/minimap/in_circle.o"
	"rendering/draw/minimap/fov_ray_vertical.o"
	"rendering/draw/minimap/utils.o"
	"rendering/draw/minimap/update_minimap.o"
	"rendering/draw/line.o"
	"rendering/draw/hit.o"
	"rendering/draw/switch_textures.o"
	"rendering/draw/raycast.o"
	"rendering/draw/fov.o"
	"debug/render.o"
	"debug/keypress.o"
	"debug/error.o"
	"debug/render.line.o"
	"debug/print.o"
	"debug/parsing.o"
	"debug/ray.o"
	"debug/map.o"
	"parsing/utils.1.o"
	"parsing/params.o"
	"parsing/line/color.o"
	"parsing/line/texture.o"
	"parsing/line/file_list/list.o"
	"parsing/line/entry.o"
	"parsing/dup_map_squared.o"
	"parsing/ft_cub3d_split.o"
	"parsing/entry.o"
	"parsing/map/check.door.surrounded.o"
	"parsing/map/check.surrounded.o"
	"parsing/map/entry.o"
	"parsing/map/content.o"
	"error/set/texture.o"
	"error/set/params.o"
	"error/set/entry.o"
	"error/print/malloc.o"
	"error/print/params.known.o"
	"error/print/texture.known.o"
	"error/print/texture.o"
	"error/print/error_no_print.o"
	"error/print/params.o"
	"error/print/entry.o"
	"error/print/params.color.o"
	"error/utils.o"
	"main.o"
	"dataset/init/player.o"
	"dataset/init/mlx.hook.mouse.o"
	"dataset/init/rendering.o"
	"dataset/init/texture.o"
	"dataset/init/minimap.o"
	"dataset/init/mlx.hook.o"
	"dataset/init/config.o"
	"dataset/init/file.o"
	"dataset/init/mlx.o"
	"dataset/init/parse.o"
	"dataset/free/texture.o"
	"dataset/free/mlx.hook.o"
	"dataset/free/config.o"
	"dataset/free/file.o"
	"dataset/free/mlx.o"
	"dataset/free/parse.o"
)

# FILES=(
# 	"file.1.o"
# 	"file.2.o"
# 	"file.3.o"
# 	"file.4.o"
# 	"file.with.long.name.o"
# 	"file.with.very.very.very.long.name.o"
# )

STEP_ID=0
STEP_NB="${#FILES[@]}"

PG_LEN=40
PG_FULL="="
PG_HEAD=">"
PG_EMPTY=" "

function	get_ts_ms()
{
	CURRENT_TS=$(($(date +%s%N)/1000000))
}

get_ts_ms
PG_BEGIN_TS=${CURRENT_TS}

## ANSI PART

ANSI_ESC="\033"

function	ansi_print_esc()
{
	local	code_sequence="${1}"

	printf "%b" "${ANSI_ESC}${code_sequence}"
}

function	ansi_up()
{
	local	nb_dir="${1}"

	ansi_print_esc "[${nb_dir}A"
}

function	ansi_down()
{
	local	nb_dir="${1}"

	ansi_print_esc "[${nb_dir}B"
}

function	ansi_clear_line()
{
	ansi_print_esc "[2K"
}

## PROGRESS_BAR PART

function	pg_clean_up()
{
	local	nb_line="${1}"

	ansi_up ${nb_line}
	for ((counter = 0; counter < ${nb_line}; counter++)); do
		ansi_clear_line
		ansi_down 1
	done
	ansi_up ${nb_line}
}

function	pg_first_line()
{
	local	desc="${1}"

	printf "(%d/%d) " $((STEP_ID + 1)) "${STEP_NB}"
	printf "%s\n" "${desc}"
}

function	pg_print_percentage()
{
	CURRENT_PERCENTAGE=$(((STEP_ID * 100) / ${STEP_NB}))
	printf "${CURRENT_PERCENTAGE}%%"
	printf " %.0s" $(seq 1 $((4 - ${#CURRENT_PERCENTAGE})))
}

function	pg_print_progress_bar()
{
	local	pg_full
	local	pg_empty

	if [ ${CURRENT_PERCENTAGE} -eq 0 ]; then
		pg_full=""
	else
		pg_full=$(
			printf "${PG_FULL}%.0s" \
			$(seq 2 $(((CURRENT_PERCENTAGE * PG_LEN) / 100)) )
		)
	fi
	pg_empty=$(printf "${PG_EMPTY}%.0s" \
			$(seq 2 $((PG_LEN - ${#pg_full})) ) )

	printf "[%s%s%s]" "${pg_full}" "${PG_HEAD}" "${pg_empty}"
}

function	pg_second_line()
{
	pg_print_percentage
	pg_print_progress_bar
}

function	pg_print()
{
	local	file_name="${1}"

	pg_clean_up 2
	pg_first_line ${file_name}
	pg_second_line
	echo
	((STEP_ID++))
}

function	pg_done()
{
	local	title="${1}"
	local	elapsed

	((STEP_ID--))
	pg_clean_up 2
	get_ts_ms
	elapsed=$((${CURRENT_TS} - ${PG_BEGIN_TS}))
	pg_first_line "${title}: DONE (elapsed: ${elapsed}ms)"
}

ansi_down 2

for file in "${FILES[@]}"; do
	pg_print "${file}"
	sleep 0.01
done

pg_done "obj"

