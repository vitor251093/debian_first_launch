#!/bin/bash

source ../../shared/functions.sh

# Broadcom BCM4312
# A placa de rede ethernet é uma Qualcomm Atheros AR8132.
# https://wiki.debian.org/InstallingDebianOn/Acer/AspireOne#Wireless_LAN

info "Installing Wi-Fi driver..."
sudo apt-get install linux-headers-$(uname -r) -y
sudo apt install broadcom-sta-dkms -y
sudo update-grub



# The method below wasn't tested, but may work, and be a more proper fix

# After restart edit sources.list using nano and add main contrib non-free on every line. (press CTRL O to save and CTRL X to exit)
# sudo nano /etc/apt/sources.list

# sudo apt-get update
# sudo apt-get dist-upgrade

# And reboot the computer again (systemctl reboot)

# Install Broadcom drivers

# sudo apt-get install linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms

# sudo modprobe -r b44 b43 b43legacy ssb brcmsmac bcma

# sudo modprobe wl

# After all that is done you will have wifi! to see all the available connections in your area type nmcli device wifi list (if you don't see anything then the installation wasn't done properly)

# Fonte: https://serverfault.com/a/1047961

