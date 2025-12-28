#!/usr/bin/env bash

###############################################################################
# Termux Native Build Environment
# Compatible architectures: aarch64, arm, i686, x86_64
# This script configures compilers, flags, and Termux prefix paths.
###############################################################################

# Detect architecture and assign the correct Android target triple
case "$(uname -m)" in
  aarch64)
    export TERMUX_ARCH="aarch64"
    export TERMUX_TARGET="aarch64-linux-android"
    ;;
  armv7l|armv8l)
    export TERMUX_ARCH="arm"
    export TERMUX_TARGET="armv7a-linux-androideabi"
    ;;
  i686)
    export TERMUX_ARCH="i686"
    export TERMUX_TARGET="i686-linux-android"
    ;;
  x86_64)
    export TERMUX_ARCH="x86_64"
    export TERMUX_TARGET="x86_64-linux-android"
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)"
    return 1
    ;;
esac

# Android API level Termux uses
export TERMUX_API=24

# Compiler toolchain
export CC="clang"
export CXX="clang++"
export AR="ar"
export RANLIB="ranlib"
export LD="ld"

# Core build flags
export CFLAGS="--target=${TERMUX_TARGET}${TERMUX_API} \
               -I${PREFIX}/include \
               -fPIC -fPIE"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-L${PREFIX}/lib -fPIE -pie"

# Optional: optimization and debugging settings
export CFLAGS="$CFLAGS -O2"
export CXXFLAGS="$CXXFLAGS -O2"

###############################################################################
# Python wheel build support
###############################################################################
# Many Python packages (e.g., cryptography, lxml, Pillow) require proper flags.

export PYTHON_CFLAGS="$CFLAGS"
export PYTHON_LDFLAGS="$LDFLAGS"

# Useful when using pip for native builds
export PIP_BUILD_ISOLATION=0

echo "Termux build environment configured."
echo "ARCH:  $TERMUX_ARCH"
echo "TARGET ${TERMUX_TARGET}${TERMUX_API}"