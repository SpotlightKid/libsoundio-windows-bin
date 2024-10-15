#!/bin/bash

set -e

SRC_DIR="$1"
BUILD_DIR="build-$1-$2"
INSTALL_ROOT="dist-$1-$2"

cmake \
    -B "$BUILD_DIR" \
    -S "$SRC_DIR" \
    -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILD_DIR"
DESTDIR="$INSTALL_ROOT" cmake --install "$BUILD_DIR"
