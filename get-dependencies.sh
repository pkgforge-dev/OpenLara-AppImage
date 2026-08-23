#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm sdl3

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building OpenLara..."
echo "---------------------------------------------------------------"
REPO="https://github.com/XProger/OpenLara"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./OpenLara
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./OpenLara/src/platform/sdl3
make -j$(nproc)
mv -v openlara ../../../../AppDir/bin
