#!/bin/bash
cd SDL

make distclean
./autogen.sh

./configure \
 --host=arm-linux-gnueabi \
 CC=arm-linux-gnueabi-gcc \
 CXX=arm-linux-gnueabi-g++ \
 CFLAGS="-std=gnu99 -march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
 CXXFLAGS="${CFLAGS}" \
 LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
 --disable-mmx --disable-3dnow --disable-sse --disable-sse2 --disable-sse3 --disable-altivec \
 --disable-video-x11 \
 --disable-video-wayland \
 --disable-video-opengl \
 --disable-video-opengles \
 --disable-video-vulkan \
 --disable-joystick \
 --enable-video-directfb \
 --disable-directfb-shared

CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CC_FOR_BUILD="gcc" \
CXX_FOR_BUILD="g++" \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
make

sudo make install

cd ..
echo "SDL2 is ready."
