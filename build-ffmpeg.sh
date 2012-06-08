#!/bin/bash -e

BRANCH="release/0.8"

if [ "$LIBFAAC" = "true" ]; then
    FAACOPTIONS="--enable-libfaac --enable-nonfree"
fi

if [ -d "ffmpeg" ]; then
    pushd ffmpeg
    if [ -f "Makefile" ]; then
        make distclean || true
    fi
    git pull
    popd
else
    git clone --depth 1 git://source.ffmpeg.org/ffmpeg
fi

pushd ffmpeg
git checkout $BRANCH
./configure --enable-gpl --enable-libmp3lame --enable-libopencore-amrnb \
    --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis \
    --enable-libx264 --enable-libvpx $FAACOPTIONS \
    --enable-version3 --enable-x11grab
make
VERSION=$(./version.sh)
echo "ffmpeg - Nuxeo version" > description-pak
checkinstall --pkgname=ffmpeg-nuxeo --pkgversion="$VERSION" \
    --conflicts=ffmpeg,libav-tools --replaces=ffmpeg,libav-tools \
    --provides=ffmpeg --requires=x264-nuxeo,libvpx-nuxeo \
    --maintainer="'Nuxeo Packagers <packagers@nuxeo.com>'" \
    --backup=no --deldoc=yes --deldesc=yes --fstrans=no --default
popd

