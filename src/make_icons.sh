#!/bin/bash

cd "${0%/*}"

OUT="./icons"
SCALE_PRESET=(6 8 10 12 14 16)

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

function render_bitmap() {
    resolution=${1}
    input_file=${2}
    output_file=$OUT_DIR/`basename ${input_file} svg`png
    echo "Creating $output_file"
    #unfortunately, rEFInd stretches the icons out to what it thinks are squares; otherwise this could mix aspect ratio mismatches.
	#inkscape -h=$resolution -w=$(($RATIO_FOR_SQUARE*$resolution/100)) --export-png="$output_file" $input_file > /dev/null \
	inkscape -h=$resolution --export-png="$output_file" $input_file > /dev/null \
 && which optipng &> /dev/null && optipng -o7 --quiet "$output_file"
}

for i in ${SCALE_PRESET[@]}; do
    SCALE=$i
    BIG_ICON_SIZE=$(($BIG_ICON_BASE_SIZE*$SCALE))
    SMALL_ICON_SIZE=$(($SMALL_ICON_BASE_SIZE*$SCALE))
    OUT_DIR="$OUT/${BIG_ICON_SIZE}_${SMALL_ICON_SIZE}"
    mkdir -p $OUT_DIR
    for icon in svg/os_* svg/mouse.svg ; do
        render_bitmap $BIG_ICON_SIZE ${icon}
    done
    for icon in svg/arrow_* svg/func_* svg/tool_* ; do
        render_bitmap $SMALL_ICON_SIZE ${icon}
    done
    for icon in svg/vol_* svg/background.svg svg/transparent.svg ; do
        render_bitmap $(($BIG_ICON_SIZE/4)) ${icon}
    done
    render_bitmap $((9*$BIG_ICON_SIZE/8)) svg/selection_big.svg
    render_bitmap $((4*$SMALL_ICON_SIZE/3)) svg/selection_small.svg
done
