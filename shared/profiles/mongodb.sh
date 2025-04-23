#!/bin/bash

source ./shared/functions.sh

info "Installing MongoDB Compass..."
wget https://downloads.mongodb.com/compass/mongodb-compass_1.44.7_amd64.deb
sudo dpkg -i mongodb-compass_1.44.7_amd64.deb
