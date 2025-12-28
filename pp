#!/usr/bin/env bash
WHL="/data/data/com.termux/files/home/tmp/whl"
mkdir -p "$WHL"
pip download --verbose --no-deps "$@" -d "$WHL"
pip install --verbose --no-deps "$@"
