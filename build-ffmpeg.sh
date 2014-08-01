#!/bin/bash -e

RELEASE="1.1.9"

if [ "$LIBFAAC" = "true" ]; then
    FAACOPTIONS="--enable-libfaac --enable-nonfree"
fi

if [ -d "ffmpeg-$RELEASE" ]; then
    pushd ffmpeg-$RELEASE
    if [ -f "Makefile" ]; then
        make distclean || true
    fi
    popd
else
    wget http://www.ffmpeg.org/releases/ffmpeg-$RELEASE.tar.bz2
    tar xjf ffmpeg-$RELEASE.tar.bz2
fi

pushd ffmpeg-$RELEASE
./configure --enable-gpl --enable-libmp3lame --enable-libopencore-amrnb \
    --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis \
    --enable-libx264 --enable-libvpx $FAACOPTIONS \
    --enable-version3 --enable-x11grab --extra-libs="-ldl"
make
echo "ffmpeg - Nuxeo version" > description-pak
checkinstall --pkgname=ffmpeg-nuxeo --pkgversion="$RELEASE" \
    --conflicts=ffmpeg,libav-tools --replaces=ffmpeg,libav-tools \
    --provides=ffmpeg --maintainer="'Nuxeo Packagers <packagers@nuxeo.com>'" \
    --requires=x264-nuxeo,libvpx-nuxeo,libjack-jackd2-dev,libmp3lame-dev,libopencore-amrnb-dev,libopencore-amrwb-dev,libsdl1.2-dev,libtheora-dev,libva-dev,libvdpau-dev,libvorbis-dev,libx11-dev,libxfixes-dev,texi2html,zlib1g-dev \
    --backup=no --deldoc=yes --deldesc=yes --fstrans=no --default
popd

