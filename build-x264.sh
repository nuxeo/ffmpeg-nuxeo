#!/bin/bash -e

# For yasm < 1.2.0
BRANCH="b924133cabd125286488e16cfa71488ad4105d63~"
YASM_VERSIONS=$(apt-cache madison yasm | grep 'Packages$' | cut -d '|' -f 2)
for yasm_version in $YASM_VERSIONS; do
  # yasm >= 1.2.0 found
  dpkg --compare-versions "$yasm_version" ge "1.2.0" && BRANCH="stable" && break
done

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

