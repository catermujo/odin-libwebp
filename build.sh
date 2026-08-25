#!/usr/bin/env bash

set -euo pipefail

BASE="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$BASE/libwebp"

case "$(uname -s):$(uname -m)" in
    Darwin:arm64 | Darwin:aarch64) PLATFORM=darwin_arm64 ;;
    Darwin:x86_64 | Darwin:amd64) PLATFORM=darwin_x64 ;;
    Linux:x86_64 | Linux:amd64) PLATFORM=linux_x64 ;;
    Linux:aarch64 | Linux:arm64) PLATFORM=linux_arm64 ;;
    *) echo "Unsupported platform: $(uname -s) $(uname -m)" >&2; exit 1 ;;
esac

BUILD="$BASE/build_$PLATFORM"
OUTPUT="$BASE/$PLATFORM"
mkdir -p "$OUTPUT/include/webp" "$OUTPUT/lib" "$OUTPUT/licenses"

cmake -S "$SOURCE" -B "$BUILD" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DWEBP_BUILD_ANIM_UTILS=OFF \
    -DWEBP_BUILD_CWEBP=OFF \
    -DWEBP_BUILD_DWEBP=OFF \
    -DWEBP_BUILD_GIF2WEBP=OFF \
    -DWEBP_BUILD_IMG2WEBP=OFF \
    -DWEBP_BUILD_VWEBP=OFF \
    -DWEBP_BUILD_WEBPINFO=OFF \
    -DWEBP_BUILD_WEBPMUX=OFF \
    -DWEBP_BUILD_EXTRAS=OFF \
    -DWEBP_BUILD_WEBP_JS=OFF \
    -DWEBP_BUILD_FUZZTEST=OFF \
    -DWEBP_BUILD_LIBWEBPMUX=ON \
    -DWEBP_ENABLE_SIMD=ON \
    -DWEBP_USE_THREAD=OFF
cmake --build "$BUILD" --config Release --parallel 6 --target webp webpdemux libwebpmux

cp "$BUILD/libsharpyuv.a" "$BUILD/libwebp.a" "$BUILD/libwebpdemux.a" "$BUILD/libwebpmux.a" "$OUTPUT/lib/"
cp "$SOURCE/src/webp/"*.h "$OUTPUT/include/webp/"
cp "$SOURCE/COPYING" "$SOURCE/PATENTS" "$OUTPUT/licenses/"

