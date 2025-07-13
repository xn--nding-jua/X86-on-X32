#!/bin/bash
cd fbvnc
CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- \
CFLAGS="-march=armv5te -mtune=arm926ej-s -mfloat-abi=softfp" \
CXXFLAGS="${CFLAGS}" \
LDFLAGS="-L/usr/local/lib -L/usr/lib/arm-linux-gnueabi -lz" \
CC="${CROSS_COMPILE}gcc" \
CXX="${CROSS_COMPILE}g++" \
LD="${CROSS_COMPILE}ld" \
AR="${CROSS_COMPILE}ar" \
RANLIB="${CROSS_COMPILE}ranlib" \
make

cd ..
echo "FBVNC is ready."
