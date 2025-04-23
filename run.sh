#!/bin/bash
set -e

cd "$(dirname "$0")"

lock_file="./current_step.lock"
if [[ -f "$lock_file" ]]; then
  lock=$(cat "$lock_file")
else
  lock="false"
fi
if [[ "$lock" == "true" ]]; then
  echo "Nothing else needs to be done"
  exit 0
fi

state_file="./current_step.state"
if [[ -f "$state_file" ]]; then
  step=$(cat "$state_file")
else
  step="1"
fi

profiles_file="./current_profiles.state"
if [[ -f "$profiles_file" ]]; then
  profiles=$(cat "$profiles_file")
else
  echo "Available profiles:"
  available_profiles=$(ls ./shared/profiles/*.sh 2>/dev/null | xargs -n 1 basename | sed 's/\.sh$//')
  echo "$available_profiles"

  read -p "Enter the profiles to use (comma-separated or 'all' for all profiles): " profiles
  if [[ "$profiles" == "all" ]]; then
    profiles=$(echo "$available_profiles" | tr '\n' ',' | sed 's/,$//')
  fi
  echo "$profiles" > "$profiles_file"
fi

hardware_file="./current_hardware.state"
if [[ -f "$hardware_file" ]]; then
  hardware_name=$(cat "$hardware_file")
else
  hardware_name=$(cat /sys/devices/virtual/dmi/id/product_name)
  hardware_dir="./hardware/$hardware_name"
  if [[ ! -d "$hardware_dir" ]]; then
    echo "Hardware directory for $hardware_name not found."
    echo "Would you like to fall back to the generic hardware directory? (y/n)"
    read -p "Proceeding with the generic directory may not make everything work out of the box. Are you sure? " user_input
  
    if [[ "$user_input" != "y" && "$user_input" != "Y" ]]; then
      echo "Aborting script execution."
      exit 1
    fi

    hardware_name="generic"
  fi
  echo "$hardware_name" > "$hardware_file"
fi
hardware_dir="./hardware/$hardware_name"

install_script="$hardware_dir/install_$step.sh"
if [[ -f "$install_script" ]]; then
  chmod +x "$install_script"
  bash "$install_script" "$profiles"
  
  ((step++))
  echo "$step" > "$state_file"
else
  if [[ -f "./extra.sh" ]]; then
    bash "./extra.sh"
  fi

  echo "true" > "$lock_file"
  echo "Nothing else needs to be done"
fi
