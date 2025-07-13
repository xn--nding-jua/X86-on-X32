#!/bin/bash
cd DirectFB

make distclean
./autogen.sh

CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CC_FOR_BUILD="gcc" \
CXX_FOR_BUILD="g++" \
LIBS="-lgcc_s -lgcc -ldl -lstdc++ -lz" \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
./configure CC=arm-linux-gnueabi-gcc --build=i686-linux --host=arm-linux-gnueabi \
 --enable-static --enable-shared \
 --enable-fbdev \
 --with-smooth-scaling \
 --with-inputdrivers=keyboard,linuxinput,ps2mouse,serialmouse,input_hub,joystick \
 --disable-png --disable-jpeg --disable-freetype \
 --disable-x11 --disable-wayland --disable-egl --disable-egl-united --disable-mesa \
 --with-gfxdrivers=none \
 --without-tools --without-tests --enable-text

CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CC_FOR_BUILD="gcc" \
CXX_FOR_BUILD="g++" \
LIBS="-lgcc_s -lgcc -ldl -lstdc++ -lz" \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
make

sudo make install

cd ..
echo "DirectFB is ready."
