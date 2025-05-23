#!/bin/bash

source ./shared/functions.sh

info "Installing NodeJS..."
sudo apt-get install npm nodejs -y
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

info "Installing VSCodium..."
# https://vscodium.com/
sudo apt-get install wget gpg
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium

