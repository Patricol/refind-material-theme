#!/bin/bash

cd "${0%/*}"

function set_color() {
    filename=$1
    color=$2
    sed -i "s/fill:#....../fill:$color/g" $filename
}

for icon in svg/os_* svg/boot_*  ; do
    set_color ${icon} "#ff0000"
done
for icon in svg/func_* svg/tool_* ; do
    set_color ${icon} "#424242"
done
for icon in svg/arrow_* ; do
    set_color ${icon} "#424242"
done
for icon in svg/vol_* ; do
    set_color ${icon} "#424242"
done
for icon in svg/selection_* ; do
    set_color ${icon} "#9e9e9e"
done

set_color svg/mouse.svg "#616161"
set_color svg/background.svg "#e0e0e0"
