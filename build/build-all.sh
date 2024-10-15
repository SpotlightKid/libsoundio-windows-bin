#!/bin/bash

set -e

REPO_URL="https://github.com/andrewrk/libsoundio.git"

if [[ $# -eq 0 ]]; then
    echo "usage: ./build_all.sh <tag-or-branch>"
    exit 1
fi

echo "Building tag/branch $1"
BRANCH_DIR="libsoundio-$1"

echo "Cloning repo to $BRANCH_DIR..."
rm -rf "$BRANCH_DIR"
git clone \
  -c advice.detachedHead=false \
  --branch $1 \
  --single-branch \
  --depth 1 \
  "$REPO_URL" \
  "$BRANCH_DIR"

echo "Applying patches..."
( cd "$BRANCH_DIR"; git apply ../patches/283.patch; )

echo "Building for Windows..."
echo "Building for 32-bit (x86)..."
./dockcross-windows-shared-x86 bash -c "sh ./build.sh $BRANCH_DIR x86"
mkdir -p ./win/x86/
cp "build-$BRANCH_DIR-x86"/libsoundio.dll win/x86/libsoundio.dll
cp "build-$BRANCH_DIR-x86"/libsoundio.dll.a win/x86/libsoundio.lib
rm -rf "build-$BRANCH_DIR-x86"

echo "Building for 64-bit (x64)..."
./dockcross-windows-shared-x64 bash -c "sh ./build.sh $BRANCH_DIR x64"
mkdir -p ./win/x64/
cp "build-$BRANCH_DIR-x64"/libsoundio.dll win/x64/libsoundio.dll
cp "build-$BRANCH_DIR-x64"/libsoundio.dll.a win/x64/libsoundio.lib
rm -rf "build-$BRANCH_DIR-x64"

echo "Moving build artifacts to root..."
rm -rf ../win
mv win ../

echo "Cleaning up"
rm -rf "$BRANCH_DIR"
