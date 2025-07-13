#!/bin/bash

echo "Compiling DirectFB..."
./build_directfb.sh

echo "Compiling SDL2..."
./build_sdl.sh

echo "Compiling QEMU..."
./build_qemu.sh

echo "Comiling FBVNC..."
./build_fbvnc.sh

echo "Done."
