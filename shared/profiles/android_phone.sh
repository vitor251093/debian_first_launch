#!/bin/bash

source ./shared/functions.sh

info "Installing scrcpy..."
# https://github.com/Genymobile/scrcpy/blob/master/doc/linux.md
sudo apt install ffmpeg libsdl2-2.0-0 adb wget \
                 gcc git pkg-config meson ninja-build libsdl2-dev \
                 libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
                 libswresample-dev libusb-1.0-0 libusb-1.0-0-dev -y

git clone https://github.com/Genymobile/scrcpy
cd scrcpy
./install_release.sh
cd ..
sudo rm -r scrcpy
sudo cp scrcpy-wifi.desktop /usr/local/share/applications/scrcpy-wifi.desktop
sudo chmod 644 /usr/local/share/applications/scrcpy-wifi.desktop