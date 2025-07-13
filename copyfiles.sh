#!/bin/bash
echo "Copying compiled files to folder <usb>..."

mkdir usb
mkdir usb/qemu
mkdir usb/qemu/lib

echo "Copying libraries for DirectFB..."
cp -r /usr/local/lib/*direct* usb/qemu/lib/
cp /usr/local/lib/*dfb* usb/qemu/lib/
cp /usr/local/lib/*fusion* usb/qemu/lib/

echo "Copying libraries for SDL2..."
cp /usr/local/lib/*SDL2* usb/qemu/lib/

echo "Copying QEMU..."
cp qemu-6.2.0/build/i386-softmmu/qemu-system-i386 usb/qemu/
cp -r qemu-6.2.0/pc-bios usb/qemu/

echo "Copying FBVNC..."
cp fbvnc/fbvnc usb/qemu/

echo "Copying FreeDOS..."
cp freedos/freedos.boot.disk.1.4MB.img usb/qemu/freedos.img

echo "Copying scripts..."
cp files/*.sh usb/qemu/

echo "Done. Caution: You have to take care, that other used libraries are copied from /usr/lib/arm-linux-gnueabi/. If you are unsure, you may copy the whole folder to the thumbdrive..."
