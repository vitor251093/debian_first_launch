#!/bin/bash

source ./shared/functions.sh

bash "./shared/de-config2.sh"


info "Installing NVIDIA drivers..."
sudo apt install nvidia-driver -y
sudo apt-get --install-suggests install nvidia-driver-libs:i386 -y
# TODO: Give reminder that Secure Boot must be disabled on the BIOS

info "Enabling HDMI port..."
xrandr --setprovideroutputsource NVIDIA-G0 modesetting
xrandr --auto