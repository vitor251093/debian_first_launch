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

sudo update-initramfs -u
sudo update-grub

