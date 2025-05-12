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
# https://wiki.debian.org/JetBrains
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt update
sudo apt install intellij-idea-community -y

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
