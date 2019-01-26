#!/bin/bash

cd "${0%/*}"

function set_color() {
    filename=$1
    color=$2
    sed -i "s/fill:#....../fill:$color/g" $filename
}

if [ -f ~/.cache/wpg/patricol_scripts/named-colors.sh ]; then
    source ~/.cache/wpg/patricol_scripts/named-colors.sh
else
    darkest='212121'
    red='d50000'
    green='00c853'
    yellow='ffd600'
    blue='2962ff'
    magenta='aa00ff'
    cyan='00b8d4'
    bright='bdbdbd'
    dark='616161'
    light_red='ff5252'
    light_green='69f0ae'
    light_yellow='ffff00'
    light_blue='448aff'
    light_magenta='e040fb'
    light_cyan='18ffff'
    brightest='eeeeee'

    brighter='e0e0e0'
    brightish='9e9e9e'
    darkish='757575'
    darker='424242'

    accent='ff0000'
    warning='ff00ff'
fi

for icon in svg/os_* svg/boot_*  ; do
    set_color ${icon} ${red}
done
for icon in svg/func_* svg/tool_* ; do
    set_color ${icon} ${darker}
done
for icon in svg/arrow_* ; do
    set_color ${icon} ${darker}
done
for icon in svg/vol_* ; do
    set_color ${icon} ${darker}
done
for icon in svg/selection_* ; do
    set_color ${icon} ${blue}
done

set_color svg/mouse.svg ${darkest}
set_color svg/background.svg ${brighter}
