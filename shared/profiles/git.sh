#!/bin/bash

source ./shared/functions.sh

info "Git config..."
sudo apt-get install libsecret-1-dev -y
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global pull.rebase false
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

echo "Which is your Github e-mail?"
read $githubemail
echo "How would like to be known by git?"
read $githubname
git config --global user.email $githubemail
git config --global user.name $githubname
