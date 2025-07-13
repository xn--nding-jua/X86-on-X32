#!/bin/sh
LD_LIBRARY_PATH=/mnt/usb/qemu/lib ./qemu-system-i386 -L /mnt/usb/qemu/pc-bios/ -machine isapc -cpu 486 -m 4 -monitor stdio -display vnc=:0 -fda freedos.img -boot a
