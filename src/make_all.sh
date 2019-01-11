#!/bin/bash

cd "${0%/*}"

./make_fonts.sh
./update_colors.sh
./make_icons.sh

rm -rf ../icons ../fonts
mv ./icons ..
mv ./fonts ..
