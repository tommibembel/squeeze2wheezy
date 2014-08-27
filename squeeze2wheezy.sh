#!/bin/bash
OLD=$(cat /etc/debian_version)

apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade

cp /etc/apt/sources.list /etc/apt/sources.list.old
cat << ENDE >/etc/apt/sources.list
deb http://ftp.de.debian.org/debian/ wheezy main
deb-src http://ftp.de.debian.org/debian/ wheezy main
 
deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
 
deb http://ftp.de.debian.org/debian/ wheezy-updates main
deb-src http://ftp.de.debian.org/debian/ wheezy-updates main
ENDE

apt-get update
apt-get -y upgrade

KERNEL=$(dpkg -l | grep linux-image | grep meta-package | awk '{print $2}')

apt-get -y install $KERNEL
update-grub

apt-get -y install udev

apt-get -y dist-upgrade

NEW=$(cat /etc/debian_version)

echo "Upgraded von Debian Version $OLD auf $NEW"
echo "Reboot in 5 Sekunden"
sleep 1
echo "Reboot in 4 Sekunden"
sleep 1 
echo "Reboot in 3 Sekunden"
sleep 1 
echo "Reboot in 2 Sekunden"
sleep 1 
echo "Reboot in 1 Sekunden"
sleep 1 
reboot
