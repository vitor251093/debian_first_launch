#!/bin/bash

source ../shared/functions.sh

info "Configuring GNOME..."

info "Adding GNOME's Flatpak repository..."
sudo apt install gnome-software-plugin-flatpak -y

info "Removing GNOME Games..."
sudo apt purge gnome-games -y
sudo apt-get remove aisleriot five-or-more four-in-a-row gnome-2048 gnome-chess gnome-klotski gnome-mahjongg gnome-mines \
   gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex hitori hoichess iagno libgnome-games-support-1-3 \
   libgnome-games-support-common libqqwing2v5 lightsoff quadrapassel swell-foop tali -y

# TODO: Install "GNOME App Folders Manager"

info "Default system configs..."
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
gsettings set org.gnome.GWeather4 temperature-unit "'centigrade'"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

info "Installing Gnome Tweaks..."
sudo apt-get install gnome-tweaks -y

info "Installing Gnome extensions..."
sudo apt install gnome-shell-extensions gnome-shell-extension-dashtodock -y
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/

info "Default Icon Tray configs..."
sudo apt install chrome-gnome-shell -y
gnome-shell-extension-installer 615 --yes
gnome-shell-extension-tool -e appindicatorsupport@rgcjonas.gmail.com

info "Default Dash-to-Dock configs..."
gnome-shell-extension-tool -e dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps false
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

info "Installing [QSTweak] Quick Setting Tweaker (Multiple tweaks)..."
gnome-shell-extension-installer 5446 --yes
gnome-shell-extension-tool -e quick-settings-tweaks@qwreey

info "Installing Notification Banner Position..."
gnome-shell-extension-installer 4105 --yes
gnome-shell-extension-tool -e notification-position@drugo.dev

info "Installing Workspace Matrix (Multiple spaces/desktops)..."
gnome-shell-extension-installer 1485 --yes
gnome-shell-extension-tool -e wsmatrix@martin.zurowietz.de

# info "Installing GSConnect (Android integration)..."
# gnome-shell-extension-installer 1319 --yes
# gnome-shell-extension-tool -e gsconnect@andyholmes.github.io

info "Installing User Themes..."
gnome-shell-extension-installer 19 --yes

info "Configuring touchpad..."
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map default

info "Installing GNOME Network Displays (Screen mirroring)..."
sudo apt install pipewire -y
flatpak install flathub org.gnome.NetworkDisplays -y

info "Installing VPN support..."
sudo apt-get install network-manager-openvpn-gnome -y



info "Adding 'Add to Dock' right click script..."
sudo apt-get install uuid-runtime -y
chmod +x new-dock-entry
sudo cp new-dock-entry /usr/local/bin/
sudo mkdir -p /usr/local/share/file-manager/actions
sudo cp add-to-dock.desktop /usr/local/share/file-manager/actions/

info "Installing Stacer (System Monitor)..."
sudo apt install stacer -y

# info "Installing Flameshot (Screenshot)..."
# flatpak install flathub org.flameshot.Flameshot -y

info "Installing ULauncher (Spotlight)..."
wget -O ulauncher.deb https://github.com/Ulauncher/Ulauncher/releases/download/5.14.3/ulauncher_5.14.3_all.deb
sudo apt install ./ulauncher.deb -y
systemctl --user enable --now ulauncher
sudo chmod 777 /usr/share/applications/ulauncher.desktop 
echo "OnlyShowIn=" >> /usr/share/applications/ulauncher.desktop
sudo chmod 644 /usr/share/applications/ulauncher.desktop
rm ./ulauncher.deb
# The binary below is required so ULauncher can get the focus after Ctrl+Space is pressed
sudo apt-get install wmctrl -y

info "Installing hardinfo (System Information)..."
sudo apt install hardinfo -y
sudo apt install lshw -y
