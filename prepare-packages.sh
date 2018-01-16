#!/bin/bash

dpkg --status nuxeo > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "This should not be run on a server with the nuxeo package installed."
    echo "Please refer to the README.md"
    exit 1
fi

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get -y purge ffmpeg || true
apt-get -y purge ffmpeg-nuxeo || true
apt-get -y purge x264 || true
apt-get -y purge x264-nuxeo || true
apt-get -y purge libvpx-dev || true
apt-get -y purge libx264-dev || true
if [ "$BUILD_YASM" = "true" ]; then
    apt-get -y purge yasm || true
fi

apt-get update || true
apt-get -y install build-essential checkinstall git libjack-jackd2-dev \
    libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev \
    libtheora-dev libva-dev libvdpau-dev libvorbis-dev texi2html zlib1g-dev \
    libfreetype6-dev
if [ "$LIBFAAC" = "true" ]; then
    apt-get -y install libfaac-dev
fi
if [ "$BUILD_YASM" = "false" ] && ! (hash yasm 2>/dev/null); then
    apt-get -y install yasm
fi
