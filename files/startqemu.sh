#!/bin/sh
SDL_VIDEODRIVER=directfb SDL_DIRECTFB_LINUX_INPUT=1 LD_LIBRARY_PATH=/mnt/usb/qemu/lib ./qemu-system-i386 -L /mnt/usb/qemu/pc-bios/ -machine isapc -cpu 486 -m 4 -device isa-vga,vgamem_mb=1 -monitor stdio -fda freedos.img -boot a

