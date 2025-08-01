# X86-on-X32 - Running DOS and Windows on the Behringer X32
This repository collects some open-source-software to run an emulated x86-Computer on the Behringer X32. Why? Just for fun.

![alt_text](Documentation/win311.jpg)

## General idea
The on-board i.MX25 has 400MHz and is an ARMv5-processor with 64 MB of LPDDR-RAM. It has enough power to drive QEMU and with the help of a swap-file on an USB-thumbdrive, the memory is enough to drive an emulated x88-computer.

I'm using QEMU in version 6.2.0 as this is the last version supporting the ARMv5 as a Host-system. SDL2 drives the graphic-system redirecting the graphics to DirectFB, which outputs to the Linux-Framebuffer /dev/fb0.

During the development I faced some problems using SDL2 and DirectFB and I decided to use a second path to output the graphics. So I used a VNC-backend in QEMU to output the graphics to a VNC-server and connect a local VNC-viewer drawing to the framebuffer to output the graphics as well. You may decide which version is working for you.

## Pictures
Windows 3.11 is booting up even in the enhanced mode, but the system is pretty slow. The program manager and all tools are there, but don't expect a good UX as the RAM is swapped to the USB-thumbdrive:
![alt_text](Documentation/progman.jpg)

DOS programs on the other hand are running pretty well and are usable:
![alt_text](Documentation/dos.jpg)

## Steps to compile and load the emulator

### Step 1: Get Linux up and running on the X32
You can find all necessary steps here: [OpenX32](https://github.com/xn--nding-jua/OpenX32)

### Step 2: Init Git-Submodules and install dependencies
I'm using different open-source-tools to get this system up and running: DirectFB 1.7.7, SDL2 2.0.5 and QEMU 6.2.0. So the repository uses other GitHub-repositories as submodules. Please use the following command to checkout the main-repo together with submodules. To minimze the download-size and -time, we will clone the submodules separately:
```
git clone --depth 1 https://github.com/xn--nding-jua/X86-on-X32.git
cd X86-on-X32
./setup.sh
```

This script will initialize the git-submodules and download the QEMU-files. It will also compile and install fluxcomp, which is necessary to compile DirectFB.

### Step 3: Compile all modules
All configurations of the individual tools are within in four shell-scripts. If you want to configure and compile all tools at once, you may call build_all.sh:
```
./build_all.sh
```

This will configure, compile and install DirectFB, SDL2, QEMU and FBVNC. At the moment the dependencies will not be solved automatically, so you have to take care, that the necessary compiler-toolchain (arm-linux-gnueabi-) and the related packages are installed using the following commands:
```
sudo dpkg --add-architecture armel
sudo apt update
apt install libXXX-dev:armel
```

This will install the libraries for the cross-compiler under Debian.

### Step 4: Copy and prepare a USB-thumbdrive
When all parts are compiled successfully, you can call the script "copyfiles.sh" to collect all compiled files into the subfolder "usb". This folder can be copied to an USB-thumbdrive and loaded via the top USB-port on the Behringer X32. Its up to you, that you copy other library-files from /usr/lib/arm-linux-gnueabi/ to the subfolder "qemu/lib" on your thumbdrive.

Here is an example to mount the drive and call QEMU:
```
# mount the drive
mkdir /mnt/usb
mount /dev/sda1 /mnt/usb
cd /mnt/usb

# make a new swap-file as the 64MB of the X32 are not enough
fallocate -l 128M /mnt/usb/swapfile.img
chmod 600 /mnt/usb/swapfile.img
mkswap /mnt/usb/swapfile.img
swapon /mnt/usb/swapfile.img

# create symlink to library-folder
mkdir /usr/local
mkdir /usr/local/lib
ln -s /mnt/usb/qemu/lib/directfb-1.7-7 /usr/local/lib/directfb-1.7-7

# start the software using SDL2 and DirectFB
cd qemu
SDL_VIDEODRIVER=directfb SDL_DIRECTFB_LINUX_INPUT=1 LD_LIBRARY_PATH=/mnt/usb/qemu/lib ./qemu-system-i386 -L /mnt/usb/qemu/pc-bios/ -machine isapc -cpu 486 -m 4 -device isa-vga,vgamem_mb=1 -monitor stdio -fda freedos.img -boot a

# if you like to start using VNC
LD_LIBRARY_PATH=/mnt/usb/qemu/lib ./qemu-system-i386 -L /mnt/usb/qemu/pc-bios/ -machine isapc -cpu 486 -m 4 -monitor stdio -display vnc=:0 -fda freedos.img -boot a

# when you like to unmount the drive, use these commands
unlink /usr/local/lib/directfb-1.7-7
swapoff -a
cd /
umount /mnt/usb
```

Take care, that you place the necessary libraries to the folder "qemu/lib" on the thumbdrive. As the system only has 64MB of RAM, I decided to put all libs on the thumbdrive instead of the initramfs.

When you called "copyfiles.sh" there will be some helpful scripts that can be called from the Linux on the X32:
* prepare.sh -> creates the library-symlink and mounts the swap-file
* startqemu.sh -> starts QEMU using SDL2 and DirectFB
* startqemuvnc.sh -> starts QEMU using VNC-backend
* startvnc.sh -> starts VNC-Viewer on local-address
* stop.sh -> unlinks the library-symlink and disables the swapdrive

## Some pitfalls
* SDL is working only for versions 2.0.1 up to 2.0.5. Version 2.0.5 is not compiling under modern systems. You have to edit the Makefile after the compilation has begun. Remove the option "-Werrordeclaration-after-statement" from the EXTRA_CFLAGS and restart the make-process. Then SDL will compile without errors


## Used third-party software
* DirectFB in Version 1.7.7 (https://github.com/deniskropp/DirectFB/tree/directfb-1.7)
* SDL2 in Version 2.0.5 (https://github.com/libsdl-org/SDL/tree/release-2.0.5)
* QEMU in Version 6.2.0 (https://download.qemu.org/qemu-6.2.0.tar.bz2)
* FBVNC (https://github.com/aligrudi/fbvnc/tree/master)
* OpenX32 to run Linux on the Behringer X32 (https://github.com/xn--nding-jua/OpenX32)
