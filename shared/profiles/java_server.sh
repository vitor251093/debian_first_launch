#!/bin/bash

source ./shared/functions.sh

info "Installing Postman..."
flatpak install flathub com.getpostman.Postman -y

info "Installing Docker..."
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo usermod -aG docker $(whoami)

info "Installing IntelliJ..."
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community -y
sudo flatpak override --filesystem=/run/docker.sock com.jetbrains.IntelliJ-IDEA-Community
sudo flatpak override --filesystem=~/.docker com.jetbrains.IntelliJ-IDEA-Community
sudo flatpak override --env=DOCKER_CONFIG=/home/$(whoami)/.docker com.jetbrains.IntelliJ-IDEA-Community

info "Installing Jabba (JDK manager)..."
curl -sL https://github.com/Jabba-Team/jabba/raw/main/install.sh | bash && . ~/.jabba/jabba.sh
jabba install openjdk@1.11.0-2

info "Installing OpenJDK 21, 22 and 23..."
jabba install openjdk@21.0.2
jabba install openjdk@22.0.2
jabba install openjdk@23

info "Installing Gradle..."
wget https://services.gradle.org/distributions/gradle-8.11-bin.zip
unzip gradle-8.11-bin.zip
sudo mv gradle-8.11 /opt/gradle
sudo echo "export PATH=/opt/gradle/bin:${PATH}" | sudo tee /etc/profile.d/gradle.sh 
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v

info "Installing Maven..."
sudo apt-get install maven -y
