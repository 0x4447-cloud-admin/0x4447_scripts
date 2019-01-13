# Format SD for Raspberry PI

This commands will help you format and install a RBP system on a SD card

1. Format
1. sudo dd bs=1m if=2017-01-11-raspbian-jessie-lite.img of=/dev/disk2
1. touch ssh in root dir
1. ssh pi@IP with passwrod `raspberry`
1. sudo adduser USERNAME
1. usermod -aG sudo USERNAME
1. deluser --remove-home USERNAME
1. curl -sSL https://get.docker.com | sh
1. sudo usermod -aG docker davidgatti


1. curl -s https://packagecloud.io/install/repositories/Hypriot/Schatzkiste/script.deb.sh | sudo bash
1. sudo apt-get install git docker-compose
