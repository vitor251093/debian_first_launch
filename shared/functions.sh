#!/bin/bash

function info {
  echo "-------------------------------------------------------------"
  echo " "
  echo " $1"
  echo " "
  echo "-------------------------------------------------------------"
}

function replace_home_folder_with_symlink_to_folder {
  rm -r /home/$(whoami)/$1
  ln -s $2 /home/$(whoami)/$1
}

function add_keyboard_shortcut {
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$1/ name "$2"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$1/ command "$3"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$1/ binding "$4"
  
  favourites="$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)"
  if [[ $favourites == @as* ]] ;
  then
    favourites="${favourites:3}"
  fi

  if [ ${#favourites} -ge 5 ]; then 
    favourites="${favourites::-1}, "
  else 
    favourites="["
  fi
  favourites="$favourites'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$1/']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$favourites"
}

function add_dock_entry {
  favourites="$(dconf read /org/gnome/shell/favorite-apps)"
  if [ ${#favourites} -ge 2 ]; then 
    favourites="${favourites::-1}, "
  else 
    favourites="["
  fi
  favourites="$favourites'$1']"
  dconf write /org/gnome/shell/favorite-apps "$favourites"
}

function validate_if_user_has_sudo_group {
  if groups "$USER" | grep -q "\bsudo\b"; then
    echo "User has the sudo group, as expected"
  else
    echo "User does not have the sudo group. That must be fixed before running it"
    exit 1
  fi
}

function validate_if_secure_boot_is_disabled {
  if [ -d "/sys/firmware/efi" ]; then
    secureboot=$(mokutil --sb-state 2>/dev/null)
    
    if [[ "$secureboot" == *"SecureBoot enabled"* ]]; then
        echo "Secure Boot is enabled. Disable it, and then try again"
        exit 1
    else
        echo "Secure Boot is disabled."
    fi
  else
    echo "This system is not running UEFI, Secure Boot is not available."
  fi
}