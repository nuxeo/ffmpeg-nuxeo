#!/bin/bash -e

BRANCH="stable"

if [ -d "x264" ]; then
    pushd x264
    if [ -f "Makefile" ]; then
        make distclean || true
    fi
    git pull
    popd
else
    git clone git://git.videolan.org/x264
fi

pushd x264
git checkout $BRANCH
./configure --enable-static
make
VERSION=$(./version.sh | awk -F'[" ]' '/POINT/{print $4"+git"$5}')
echo "x264 - Nuxeo version" > description-pak
checkinstall --pkgname=x264-nuxeo --pkgversion="1:$VERSION" \
    --conflicts=x264 --replaces=x264 \
    --maintainer="'Nuxeo Packagers <packagers@nuxeo.com>'" \
    --backup=no --deldoc=yes --deldesc=yes --fstrans=no --default
popd

