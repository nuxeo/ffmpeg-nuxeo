#!/bin/bash -e

BRANCH="stable"

if [ -d "x264" ]; then
    pushd x264
    # Can't pull if is on a detached head 
    git pull 2>/dev/null || git fetch --all
    git checkout $BRANCH
    if [ -f "Makefile" ]; then
        make distclean || true
    fi
    popd
else
    git clone https://git.videolan.org/git/x264.git
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

