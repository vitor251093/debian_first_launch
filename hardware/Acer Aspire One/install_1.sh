#!/bin/bash

source ../../shared/functions.sh

validate_if_user_has_sudo_group
validate_if_secure_boot_is_disabled

info "Preparing network manager..."
sudo apt-get update
sudo apt-get install network-manager
systemctl enable NetworkManager 
systemctl start NetworkManager 
systemctl reboot
