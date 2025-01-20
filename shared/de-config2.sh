#!/bin/bash

source ../shared/functions.sh

info "Setting Yaru-purple-dark theme..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-purple-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-purple-dark'
gsettings set org.gnome.desktop.sound theme-theme 'Yaru'
gsettings set org.gnome.desktop.shell.extensions.user-theme name 'Yaru-purple-dark'


info "Default Icon Tray configs..."
gnome-shell-extension-tool -e appindicatorsupport@rgcjonas.gmail.com

info "Enabling Dash-to-Dock..."
gnome-shell-extension-tool -e dash-to-dock@micxgx.gmail.com

info "Enabling [QSTweak] Quick Setting Tweaker (Multiple tweaks)..."
gnome-shell-extension-tool -e quick-settings-tweaks@qwreey
gsettings --schemadir ~/.local/share/gnome-shell/extensions/quick-settings-tweaks@qwreey/schemas/ set org.gnome.shell.extensions.quick-settings-tweaks user-removed-buttons "['DarkModeToggle', 'NightLightToggle', 'DndQuickToggle', 'RfkillToggle', 'PowerProfilesToggle']"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/quick-settings-tweaks@qwreey/schemas/ set org.gnome.shell.extensions.quick-settings-tweaks list-buttons "[{"name":"Clutter_Actor","label":null,"visible":true},{"name":"SystemItem","label":null,"visible":true},{"name":"OutputStreamSlider","label":null,"visible":true},{"name":"St_BoxLayout","label":null,"visible":true},{"name":"InputStreamSlider","label":null,"visible":false},{"name":"BrightnessItem","label":null,"visible":true},{"name":"NMWiredToggle","label":null,"visible":false},{"name":"NMWirelessToggle","label":"Andre","visible":true},{"name":"NMModemToggle","label":null,"visible":false},{"name":"NMBluetoothToggle","label":null,"visible":false},{"name":"NMVpnToggle","label":"VPN","visible":true},{"name":"BluetoothToggle","label":"Bluetooth","visible":true},{"name":"PowerProfilesToggle","label":"Balanced","visible":true},{"name":"NightLightToggle","label":"Night Light","visible":true},{"name":"DarkModeToggle","label":"Dark Mode","visible":true},{"name":"RfkillToggle","label":"Airplane Mode","visible":true},{"name":"RotationToggle","label":"Auto Rotate","visible":false},{"name":"DndQuickToggle","label":"Do Not Disturb","visible":true},{"name":"MediaSection","label":null,"visible":false},{"name":"Notifications","label":null,"visible":false}]"

info "Installing Notification Banner Position..."
gnome-shell-extension-tool -e notification-position@drugo.dev

info "Enabling Workspace Matrix..."
gnome-shell-extension-tool -e wsmatrix@martin.zurowietz.de
gsettings --schemadir ~/.local/share/gnome-shell/extensions/wsmatrix@martin.zurowietz.de/schemas/ set org.gnome.shell.extensions.wsmatrix-settings num-columns 6
gsettings --schemadir ~/.local/share/gnome-shell/extensions/wsmatrix@martin.zurowietz.de/schemas/ set org.gnome.shell.extensions.wsmatrix-settings num-rows 1

# Note: GSConnect won't work with GNOME 43, only GNOME 44
#info "Enabling GSConnect..."
#gnome-shell-extension-tool -e gsconnect@andyholmes.github.io
# https://github.com/GSConnect/gnome-shell-extension-gsconnect/issues/1476


# info "Adding Flameshot keyboard shortcuts..."
# add_keyboard_shortcut 0 'Screenshot (Full screen)' "/usr/bin/flatpak run org.flameshot.Flameshot full --path $HOME/Desktop/" '<Primary><Shift>numbersign'
# add_keyboard_shortcut 1 'Screenshot (Partial)' "/usr/bin/flatpak run org.flameshot.Flameshot gui --path $HOME/Desktop/" '<Primary><Shift>dollar'

info "Adding ULauncher keyboard shortcut..."
add_keyboard_shortcut 2 'ULauncher (Spotlight)' 'ulauncher-toggle' '<Primary>space'

