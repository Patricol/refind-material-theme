#!/bin/bash
# Heavily edited; original version from: https://github.com/munlik/refind-theme-regular

cd "${0%/*}"

OUT="./icons"
SCALE_PRESET=(6 10 12 16)

UEFI_ASPECT_RATIO_H=4
UEFI_ASPECT_RATIO_W=5
SCREEN_ASPECT_RATIO_H=9
SCREEN_ASPECT_RATIO_W=16

RATIO_FOR_SQUARE=$((100*(100*$SCREEN_ASPECT_RATIO_H/$SCREEN_ASPECT_RATIO_W)/(100*$UEFI_ASPECT_RATIO_H/$UEFI_ASPECT_RATIO_W)))


#Must be >=(32/min(SCALE_PRESET)) divisible by 8; selection-big is 9/8 its size.
BIG_ICON_BASE_SIZE=16

#Must be >=(32/min(SCALE_PRESET)) and divisible by 3; selection-small is 4/3 its size.
SMALL_ICON_BASE_SIZE=6

rm -rf "$OUT"

function render_bitmap_icons() {
    render_bitmap_considering_aspect_ratio $@
    #render_bitmap $@
}

function optimize_png() {
    output_file=${1}
    which optipng &> /dev/null && optipng -o7 --quiet "$output_file"
}

function render_bitmap_considering_aspect_ratio() {
    resolution=${1}
    input_file=${2}
    output_file=$OUT_DIR/`basename ${input_file} svg`png
    gravity=${3:-"center"}
    echo "Creating $output_file"
	inkscape -h=$resolution -w=$(($RATIO_FOR_SQUARE*$resolution/100)) --export-png="$output_file" $input_file > /dev/null \
 && convert $output_file -gravity $gravity -background transparent -extent "${resolution}x${resolution}" $output_file \
 && optimize_png $output_file
}

function render_bitmap() {
    resolution=${1}
    input_file=${2}
    output_file=$OUT_DIR/`basename ${input_file} svg`png
    echo "Creating $output_file"
	inkscape -h=$resolution --export-png="$output_file" $input_file > /dev/null \
 && optimize_png $output_file
}

for i in ${SCALE_PRESET[@]}; do
    SCALE=$i
    BIG_ICON_SIZE=$(($BIG_ICON_BASE_SIZE*$SCALE))
    SMALL_ICON_SIZE=$(($SMALL_ICON_BASE_SIZE*$SCALE))
    OUT_DIR="$OUT/${BIG_ICON_SIZE}_${SMALL_ICON_SIZE}"
    mkdir -p $OUT_DIR
    for icon in svg/os_* ; do
        render_bitmap_icons $BIG_ICON_SIZE ${icon}
    done
    for icon in svg/arrow_* svg/func_* svg/tool_* ; do
        render_bitmap_icons $SMALL_ICON_SIZE ${icon}
    done
    for icon in svg/vol_* svg/transparent.svg ; do
        render_bitmap_icons $(($BIG_ICON_SIZE/4)) ${icon}
    done
    render_bitmap_icons $((9*$BIG_ICON_SIZE/8)) svg/selection_big.svg
    render_bitmap_icons $((4*$SMALL_ICON_SIZE/3)) svg/selection_small.svg
    render_bitmap_icons $SMALL_ICON_SIZE svg/mouse.svg northwest
done

OUT_DIR=$OUT
render_bitmap $BIG_ICON_SIZE svg/background.svg
