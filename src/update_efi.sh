#!/bin/bash

cd "${0%/*}"

mount /dev/sda1 /boot/efi/
rm -rf /boot/efi/EFI/refind/refind-material-theme
cp -r .. /boot/efi/EFI/refind/refind-material-theme
rm -rf /boot/efi/EFI/refind/refind-material-theme/{src,.git}
umount /boot/efi
