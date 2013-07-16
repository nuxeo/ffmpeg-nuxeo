#!/bin/bash -e

if test -n "$(apt-cache search libfaac-dev)"; then
  LIBFAAC_DEFAULT=true
else
  LIBFAAC_DEFAULT=false
fi
LIBFAAC=${1:-$LIBFAAC_DEFAULT}

cd $(dirname "$0")

export LIBFAAC
./prepare-packages.sh
./build-x264.sh
./build-libvpx.sh
./build-ffmpeg.sh

