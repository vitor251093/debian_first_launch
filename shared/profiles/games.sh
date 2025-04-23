#!/bin/bash

source ./shared/functions.sh

info "Installing OBS Studio (Video Recorder)..."
flatpak install flathub com.obsproject.Studio -y

info "Installing Discord..."
flatpak install flathub com.discordapp.Discord -y

info "Installing Lutris..."
flatpak install flathub net.lutris.Lutris -y

# I like it, very much, but at this moment, the only game I'm playing is from Lutris, and isn't being currectly launched by Cartridges
#info "Installing Cartridges..."
#flatpak install flathub hu.kramo.Cartridges -y

info "Installing Steam..."
sudo dpkg --add-architecture i386
sudo apt install steam -y

