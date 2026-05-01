#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    clang    \
    libdecor

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
if [ "$ARCH" = "x86_64" ]; then
    make-aur-package openlara-git
else
    PRE_BUILD_CMDS='sed -i "\|strip ../../../bin/OpenLara|d" src/platform/nix/build.sh' make-aur-package openlara-git
fi

# If the application needs to be manually built that has to be done down here
