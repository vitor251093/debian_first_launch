#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: $0 \"profile1,profile2,profile3\""
  exit 1
fi

source ../../shared/functions.sh

validate_if_user_has_sudo_group
validate_if_secure_boot_is_disabled

bash "../../shared/install.sh" "$1"
bash "../../shared/de-config1.sh"


info "Adjusting startup look..."
echo GRUB_THEME=grub-bgrt | sudo tee -a /etc/default/grub
echo GRUB_BACKGROUND="" | sudo tee -a /etc/default/grub

# TODO: Fill field below in /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3 rd.systemd.show_status=false rd.udev.log_level=3 splash"

# TODO: I don't know if that is needed every time, or only because I was using an updated Debian 12
# https://www.reddit.com/r/debian/comments/149jx0y/wayland_not_available_in_gdm_after_installing/

sudo update-initramfs -u
sudo update-grub

