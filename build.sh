#!/bin/bash

# Text colors
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;36m'
COLOR_RESET='\033[0m'

# Error message and exit function
fail() {
    MESSAGE=$1
    >&2 echo -e "\n${COLOR_RED}**ERROR**\n$MESSAGE${COLOR_RESET}"
    exit 1
}

# Make the output dir
SCRIPT_PATH=$(readlink -f "$0")
WORKING_DIR=$(dirname "$SCRIPT_PATH")
mkdir -p $WORKING_DIR/out
cd $WORKING_DIR/out || fail "Failed to move to out directory."

# Build the overlay
echo -e "${COLOR_BLUE}=== Building the Proteus Device Tree Overlay ===${COLOR_RESET}"
OVERLAY_NAME="sta-led-overlay.dtbo"
dtc -O dtb -o $OVERLAY_NAME -@ $WORKING_DIR/overlays/sta-led-overlay.dts || fail "Failed to build the overlay."
cp $OVERLAY_NAME $WORKING_DIR/pkg/boot/proteus
echo -e "${COLOR_GREEN}=== Build Successful! ===${COLOR_RESET}\n"

# Build the package
echo -e "${COLOR_BLUE}=== Building the Proteus Overlay Package ===${COLOR_RESET}"
dpkg-deb --build $WORKING_DIR/pkg || fail "Failed to build the package."
VERSION=$(dpkg-deb -I $WORKING_DIR/pkg.deb | grep Version | sed 's/^ //g' | cut -d ' ' -f 2)
PKG_NAME="proteus-overlay-$VERSION.deb"
mv $WORKING_DIR/pkg.deb $PKG_NAME || fail "Failed to move the package to the output folder."
echo -e "${COLOR_GREEN}=== Build Successful! ===${COLOR_RESET}\n"

echo "Overlay: $WORKING_DIR/out/$OVERLAY_NAME"
echo "Package: $WORKING_DIR/out/$PKG_NAME"
