#!/bin/bash

source ./shared/functions.sh

info "Installing Slack..."
# https://slack.com/downloads/instructions/linux?ddl=1&build=deb
wget https://downloads.slack-edge.com/desktop-releases/linux/x64/4.41.97/slack-desktop-4.41.97-amd64.deb
sudo apt install -f ./slack-desktop-4.41.97-amd64.deb

info "Installing GIMP..."
flatpak install flathub org.gimp.GIMP -y

info "Installing Inkscape..."
flatpak install flathub org.inkscape.Inkscape -y

info "Installing MegaSync..."
# https://mega.io/pt-br/desktop#download
wget https://mega.nz/linux/repo/Debian_12/amd64/megasync-Debian_12_amd64.deb && sudo apt install "$PWD/megasync-Debian_12_amd64.deb" -y

info "Installing Transmission..."
flatpak install flathub com.transmissionbt.Transmission -y

info "Installing Kdenlive..."
flatpak install flathub org.kde.kdenlive -y

info "Installing Tube Converter..."
flatpak install flathub org.nickvision.tubeconverter -y

# TODO: Install "DaVinci Resolve" manually
# chmod +x ./DaVinci_Resolve_18.0.4_Linux.run
# sudo ./DaVinci_Resolve_18.0.4_Linux.run -i

info "Creating macOS VM..."
sudo apt-get install -y qemu-system spice-client-gtk
cd /data
git clone --filter=blob:none https://github.com/wimpysworld/quickemu

info "Configuring Music folder..."
replace_home_folder_with_symlink_to_folder "Music" "/home/$(whoami)/MEGAsync/Music"

info "Adding Dock default apps..."
add_dock_entry 'org.gnome.Nautilus.desktop'
add_dock_entry 'virtualbox.desktop'
add_dock_entry 'librewolf.desktop'
add_dock_entry 'org.gnome.Calendar.desktop'
add_dock_entry 'org.gnome.TextEditor.desktop'
add_dock_entry 'code.desktop'
add_dock_entry 'com.jetbrains.IntelliJ-IDEA-Community.desktop'
add_dock_entry 'com.getpostman.Postman.desktop'
add_dock_entry 'org.gnome.Terminal.desktop'
add_dock_entry 'com.discordapp.Discord.desktop'
./new-dock-entry $HOME
./new-dock-entry $HOME/Downloads
