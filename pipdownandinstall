#!/usr/bin/env bash
WHL="/data/data/com.termux/files/home/tmp/whl"
mkdir -p "$WHL"
PKG="$@"
python -m pip download --verbose --no-deps "$PKG" -d "$WHL"
python -m pip install --verbose --no-deps "$PKG"
