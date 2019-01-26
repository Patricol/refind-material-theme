#!/bin/bash

cd "${0%/*}"

rm -rf /boot/EFI/refind/theme
cp -r .. /boot/EFI/refind/theme
rm -rf /boot/EFI/refind/theme/{src,.git,README.md,screenshot*}

