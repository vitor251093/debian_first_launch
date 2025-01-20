#!/bin/bash

source ../../shared/functions.sh

info "Preparing network manager..."
sudo apt-get update
sudo apt-get install network-manager
systemctl enable NetworkManager 
systemctl start NetworkManager 
systemctl reboot
