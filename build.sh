#!/bin/sh -e

VERSION="${VERSION:-1.5.7}"

repo=facebook/zstd
dir="zstd-$VERSION"
artifact="v$VERSION.tar.gz"
url="https://github.com/$repo/archive/$artifact"

[ -f "$artifact" ] || curl -sfLO "$url"
[ -d "$dir" ] || tar xf "$artifact"

rm -rf build
cmake -S "$dir"/build/cmake -B build -GNinja
cmake --build build
cmake --install build --prefix install

mkdir -p artifacts
mv install/bin/zstd artifacts