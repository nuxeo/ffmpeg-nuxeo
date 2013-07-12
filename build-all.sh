#!/bin/bash -e

LIBFAAC=${1:-false}

cd $(dirname "$0")

export LIBFAAC
./prepare-packages.sh
./build-x264.sh
./build-libvpx.sh
./build-ffmpeg.sh

