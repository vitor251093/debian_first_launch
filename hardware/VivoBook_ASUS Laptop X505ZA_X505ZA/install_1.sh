#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: $0 \"profile1,profile2,profile3\""
  exit 1
fi

source ./shared/functions.sh

validate_if_user_has_sudo_group
validate_if_secure_boot_is_disabled

bash "./shared/install.sh" "$1"
bash "./shared/de-config1.sh"


info "Adjusting startup look..."
echo GRUB_THEME=grub-bgrt | sudo tee -a /etc/default/grub
echo GRUB_BACKGROUND="" | sudo tee -a /etc/default/grub

# "pci=realloc pcie_aspm=off" is required so the Wi-Fi adapter is always detected properly
sudo sed -i "s,GRUB_TIMEOUT=5,GRUB_TIMEOUT=0,g" /etc/default/grub
sudo sed -i 's,GRUB_CMDLINE_LINUX_DEFAULT="quiet",GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=realloc pcie_aspm=off",g' /etc/default/grub

sudo update-initramfs -u
sudo update-grub

