#!/bin/bash -e

wget http://www.nasm.us/pub/nasm/releasebuilds/2.13.02/nasm-2.13.02.tar.bz2
tar xjvf nasm-2.13.02.tar.bz2
pushd nasm-2.13.02
./autogen.sh
./configure
make
[ "$(id -u)" != 0 ] && sudo=sudo || sudo=
$sudo checkinstall --pkgname=nasm --pkgversion="2.13.02" --backup=no --deldoc=yes --default
popd
rm nasm-2.13.02.tar.bz2

