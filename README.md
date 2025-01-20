# Debian First Launch
A script that prepares your Debian installation for use right after installing it.

This is recommended both for experienced users that just want their computer ready to use, and for newcomers, who may be a bit lost, but at least know how to use a terminal.

## What does this script do?
Basically, it gives Debian the Ubuntu look, but without the Ubuntu bloat, and with the stability of Debian Stable. It also adds some capabilities you normally find in macOS, like including folders on the Dock and using Ctrl + Space to search and open apps. And, at last, it also includes StevenBlack's host file, to improve your security on the web.

## Instructions

### How do I use this script?
First, you need to run the commands below before running this script (and you need to reboot your computer after running it):

```
su -
usermod -aG sudo your_username
exit
```

Also, remember to do not run this script with sudo, and to disable SecureBoot before running it.

All that set and done, run the `./run.sh` file. After it finishes, reboot you computer, and then run it again, until it says `Nothing else needs to be done`.

### Creating an extra.sh file
If you have some additional things you want to install, or additional configurations that you want to adjust, you can create an `extra.sh` file at the root folder of the project, and it will be executed right after everything else is done. If you aren't sure about what you can do with that file, you can take some inspiration from `sample_extra.sh`.