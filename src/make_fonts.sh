#!/bin/bash

cd "${0%/*}"

rm -rf ./fonts
mkdir -p ./fonts
for font in "Source-Code-Pro-ExtraLight" "Source-Code-Pro" ; do
    for size in  8 10 12 14 16 18 24 28 32 36 40 44 ; do
        ./make_font.sh $font $size "./fonts/${font,,}-$size.png"
    done
done
