#!/bin/bash
cd qemu-6.2.0

make distclean

CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CC_FOR_BUILD="gcc" \
CXX_FOR_BUILD="g++" \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
./configure --cross-prefix=/usr/bin/arm-linux-gnueabi- --target-list=i386-softmmu \
    --enable-system \
    --enable-sdl \
    --enable-vnc \
    --disable-sdl-image \
    --disable-opengl \
    --disable-user \
    --disable-kvm \
    --disable-xen \
    --disable-gtk \
    --disable-vte \
    --disable-spice \
    --disable-curses \
    --disable-smartcard \
    --disable-slirp \
    --disable-vhost-net \
    --disable-rdma \
    --disable-libiscsi \
    --disable-rbd \
    --disable-tpm \
    --disable-tools \
    --disable-docs \
    --disable-strip \
    --disable-debug-info \
    --disable-guest-agent \
    --disable-plugins \
    --disable-cap-ng \
    --disable-attr \
    --disable-linux-aio \
    --disable-crypto-afalg \
    --disable-gcrypt \
    --disable-nettle \
    --disable-gnutls

CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CC_FOR_BUILD="gcc" \
CXX_FOR_BUILD="g++" \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
make

cd ..
echo "QEMU is ready."
