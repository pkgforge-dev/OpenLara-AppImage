#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of OpenLara..."
echo "---------------------------------------------------------------"
REPO="https://github.com/XProger/OpenLara"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./OpenLara
echo "$VERSION" > ~/version

cd ./OpenLara/src/platform/sdl2
./build.sh
mv -v OpenLara /usr/bin
cp -rv ../psv/sce_sys/icon0.png /usr/share/pixmaps/OpenLara.png
