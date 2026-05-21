#!/bin/sh -ex

: "${VERSION:=1.5.7}"
: "${ARCH:=amd64}"

repo=facebook/zstd
dir="zstd-$VERSION"
artifact="v$VERSION.zip"
url="https://github.com/$repo/archive/$artifact"

[ -f "$artifact" ] || curl -sfLO "$url"
[ -d "$dir" ] || unzip "$artifact"

rm -rf build
cmake -S "$dir"/build/cmake -B build -GNinja \
	-DZSTD_BUILD_SHARED=OFF -DZSTD_BUILD_TESTS=OFF
cmake --build build
cmake --install build --prefix install

mkdir -p artifacts
mv install/bin/zstd artifacts/zstd-"$ARCH".exe