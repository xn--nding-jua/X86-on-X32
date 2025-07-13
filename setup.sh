#!/bin/bash
echo "Preparing checkout of DirectFB v1.7.7..."
cd DirectFB
git init
git remote add origin https://github.com/deniskropp/DirectFB.git
git fetch --depth 1 origin tag directfb-1.7
git checkout directfb-1.7
cd ..

echo "Preparing checkout of SDL2 v2.0.5..."
cd SDL
git init
git remote add origin https://github.com/libsdl-org/SDL.git
git fetch --depth 1 origin tag release-2.0.5
git checkout release-2.0.5
cd ..

echo "Checking out all remaining submodules..."
git submodule update --init --recursive

echo "Downloading QEMU v6.2.0..."
wget https://download.qemu.org/qemu-6.2.0.tar.bz2
tar -xjvf qemu-6.2.0.tar.bz2

echo "Copying modified files..."
rm fbvnc/Makefile
cp files/makefile_fbvnc fbvnc/Makefile

echo "Compiling and installing fluxcomp..."
cd flux
./autogen.sh
./configure
make
sudo make install
cd ..

echo "Done."
