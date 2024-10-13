#!/bin/bash

tag_name=$1
build_name=$2

# in case if any commands returns a non-zero error code
set -e

if [ $# -lt 2 ]; then
    echo "Usage: ./build_mupen_arm_linux.sh <tag name> <build name>" > /dev/stderr
    echo "For example: ./build_mupen_arm_linux.sh 2.6.0 crystal" > /dev/stderr
    exit 1
fi

git clone https://github.com/mupen64plus/mupen64plus-core.git --depth=1
cd mupen64plus-core
cd tools
./build_bundle_src.sh $1 $2
sudo apt install libsdl2-dev libboost-dev libboost-filesystem-dev libpng-dev libvulkan-dev
cd "mupen64plus-bundle-$2"
sudo CFLAGS='-mtune=cortex-a53 -march=armv8-a' ./m64p-build.sh NEON=1 USE_GLES=1 VFP_HARD=1 NEW_DYNAREC=1