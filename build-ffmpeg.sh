#!/bin/bash -e

RELEASE="3.4.2"

if [ "$LIBFAAC" = "true" ]; then
    FAACOPTIONS="--enable-nonfree --enable-libx264"
else
    FAACOPTIONS="--disable-libx264"
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
    --enable-libvpx $FAACOPTIONS --enable-static \
    --enable-version3 --extra-libs="-ldl -static" --extra-cflags="--static" \
    --enable-libfreetype --enable-ffplay --enable-libxvid --enable-hardcoded-tables \
    --disable-ffserver --disable-network --disable-shared
make
echo "ffmpeg - Nuxeo version" > description-pak
checkinstall --pkgname=ffmpeg-nuxeo --pkgversion="$RELEASE" \
    --conflicts=ffmpeg,libav-tools --replaces=ffmpeg,libav-tools \
    --provides=ffmpeg --maintainer="'Nuxeo Packagers <packagers@nuxeo.com>'" \
    --backup=no --deldoc=yes --deldesc=yes --fstrans=no --default
popd

