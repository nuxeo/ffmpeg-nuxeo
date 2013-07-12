#!/bin/bash -e

#BRANCH="stable"
# Before yasm version bump to 1.2.0 for AVX2 support
BRANCH="b924133cabd125286488e16cfa71488ad4105d63~"

if [ -d "x264" ]; then
    pushd x264
    if [ -f "Makefile" ]; then
        make distclean || true
    fi
    # can't pull when using a dettached head
    # git pull
    git fetch --all
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
    --conflicts=x264 --replaces=x264 --provides=x264 \
    --maintainer="'Nuxeo Packagers <packagers@nuxeo.com>'" \
    --backup=no --deldoc=yes --deldesc=yes --fstrans=no --default
popd

