#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: $0 \"profile1,profile2,profile3\""
  exit 1
fi

source ../shared/functions.sh

info "Updating installed apps..."
sudo apt-get update

info "Installing common dependencies..."
sudo apt-get install git curl p7zip-full unrar rsync -y
sudo apt install net-tools traceroute vim -y
sudo apt install dconf-editor -y
sudo apt install python3-pip -y

info "Installing fonts..."
sudo apt-get install ttf-mscorefonts-installer -y

info "Adding open command to bash..."
sudo ln -nfs /usr/bin/xdg-open /usr/bin/open

info "Installing Flatpak..."
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

info "Installing VLC..."
flatpak install flathub org.videolan.VLC -y

info "Installing LibreWolf..."
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

info "Installing Caffeine..."
sudo apt-get install caffeine -y

info "Updating hosts file..."
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
chmod 644 ./hosts
sudo cp ./hosts /etc/hosts
rm ./hosts

info "Making bash_profile be loaded by a regular terminal..."
touch ~/.bash_profile
echo "" >> ~/.bashrc
echo "# Loading bash_profile" >> ~/.bashrc
echo "source ~/.bash_profile" >> ~/.bashrc

info "Creating template files..."
mkdir -p $HOME/Templates
echo "" > "$HOME/Templates/Empty Document"

info "Installing bgrt GRUB theme..."
sudo apt-get install plymouth-themes -y
sudo apt install imagemagick -y
sudo plymouth-set-default-theme -R bgrt
git clone https://github.com/darac/grub-bgrt.git
cd grub-bgrt
sudo ./install.sh
cd ..
sudo rm -r grub-bgrt

profiles="$1"
IFS=',' read -r -a profile_array <<< "$profiles"

for profile in "${profile_array[@]}"; do
  profile_script="./profiles/$profile.sh"
  
  if [[ -f "$profile_script" ]]; then
    bash "$profile_script"
  else
    echo "File $profile_script not found"
  fi
done
