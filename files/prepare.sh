#!bin/sh
swapon /mnt/usb/swapfile.img
mkdir /usr/local
mkdir /usr/local/lib
ln -s /mnt/usb/qemu/lib/directfb-1.7-7 /usr/local/lib/directfb-1.7-7

