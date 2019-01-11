#!/bin/bash

cd "${0%/*}"

function set_color() {
    filename=$1
    color=$2
    sed -i "s/fill:#....../fill:$color/g" $filename
}

if [ -f ~/.cache/wal/named-colors.sh ]; then
    source ~/.cache/wal/named-colors.sh
else
    background=212121
    foreground=f5f5f5
    cursor=ff0000
    darkest=212121
    red=e53935
    green=43a047
    yellow=fdd835
    blue=1e88e5
    pink=d81b60
    cyan=00acc1
    brighter=e0e0e0
    dark=616161
    accent=ff0000
    accent_lighter=ff5a36
    warning=ff00ff
    brown=6d4c41
    darker=424242
    bright=9e9e9e
    brightest=f5f5f5
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
