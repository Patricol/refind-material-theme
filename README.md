# rEFInd Material Theme

### Installation:

1. Clone git repository to your $HOME directory.
   ```
   git clone https://github.com/Patricol/refind-material-theme.git
   ```

2. Locate refind directory under EFI partition. For most Linux based system is commonly `/boot/efi/EFI/refind/`. Copy theme directory to it.

   **Important:** Delete older installed versions of this theme before you proceed any further.

   ```
   sudo rm -rf /boot/efi/EFI/refind/refind-material-theme
   ```
   ```
   sudo cp -r refind-material-theme /boot/efi/EFI/refind/
   ```
3. Remove unused directories.
   ```
   sudo rm -rf /boot/efi/EFI/refind/refind-material-theme/{src,.git}
   ```

4. To adjust icon size and font size edit `theme.conf`.
   ```
   sudo nano /boot/efi/EFI/refind/refind-material-theme/theme.conf
   ```

5. To enable the theme add `include refind-material-theme/theme.conf` at the end of `refind.conf`.
   ```
   echo -e 'include refind-material-theme/theme.conf' | sudo tee -a /boot/efi/EFI/refind/refind.conf
   ```

Originally forked from: https://github.com/munlik/refind-theme-regular
