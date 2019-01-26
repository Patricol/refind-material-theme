#!/bin/bash

cd "${0%/*}"

sudo rm -rf /boot/EFI/refind/theme
sudo cp -r .. /boot/EFI/refind/theme
sudo rm -rf /boot/EFI/refind/theme/{src,.git,README.md,screenshot*}

