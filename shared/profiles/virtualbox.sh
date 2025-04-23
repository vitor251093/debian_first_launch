#!/bin/bash

source ./shared/functions.sh

info "Installing VirtualBox..."
# https://www.virtualbox.org/wiki/Linux_Downloads
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
sudo apt-get update
sudo apt-get install virtualbox-6.1 -y
sudo mkdir -p /usr/share/icons/Yaru/128x128@2x/apps/
sudo mkdir -p /usr/share/icons/Yaru/128x128/apps/
sudo mkdir -p /usr/share/icons/Yaru/64x64@2x/apps/
sudo mkdir -p /usr/share/icons/Yaru/64x64/apps/
sudo cp ../icons/virtualbox_512.png /usr/share/icons/Yaru/256x256@2x/apps/virtualbox.png
sudo cp ../icons/virtualbox_256.png /usr/share/icons/Yaru/256x256/apps/virtualbox.png
sudo cp ../icons/virtualbox_256.png /usr/share/icons/Yaru/128x128@2x/apps/virtualbox.png
sudo cp ../icons/virtualbox_128.png /usr/share/icons/Yaru/128x128/apps/virtualbox.png
sudo cp ../icons/virtualbox_128.png /usr/share/icons/Yaru/64x64@2x/apps/virtualbox.png
sudo cp ../icons/virtualbox_64.png  /usr/share/icons/Yaru/64x64/apps/virtualbox.png
sudo cp ../icons/virtualbox_64.png  /usr/share/icons/Yaru/32x32@2x/apps/virtualbox.png
sudo cp ../icons/virtualbox_32.png  /usr/share/icons/Yaru/32x32/apps/virtualbox.png
sudo cp ../icons/virtualbox_32.png  /usr/share/icons/Yaru/16x16@2x/apps/virtualbox.png
sudo cp ../icons/virtualbox_16.png  /usr/share/icons/Yaru/16x16/apps/virtualbox.png
sudo chmod 755 /usr/share/icons/Yaru/*/apps/virtualbox.png