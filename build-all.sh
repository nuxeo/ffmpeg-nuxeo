#!/bin/bash -e

if test -n "$(apt-cache search libfaac-dev)"; then
  LIBFAAC_DEFAULT=true
else
  LIBFAAC_DEFAULT=false
fi
LIBFAAC=${1:-$LIBFAAC_DEFAULT}
BUILD_YASM=${TEST:-"false"}

cd $(dirname "$0")

export LIBFAAC BUILD_YASM
./prepare-packages.sh
if [ "$BUILD_YASM" = "true" ]; then
    ./build-yasm.sh
fi
./build-x264.sh
./build-libvpx.sh
./build-ffmpeg.sh

