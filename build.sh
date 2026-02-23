#!/usr/bin/env bash

set -e
set -x

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_FLAGS_RELEASE="-Wall -Wextra -O3 -funroll-loops -DNDEBUG" \
  -DWITH_LLVM=yes \
  -DWITH_LSP=yes \
  -DWITH_STACKTRACE=no \
  -DWITH_RUNTIME_STACKTRACE=yes \
  -DUSE_DYNAMIC_ZSTD=no \
  -DCMAKE_PREFIX_PATH="$CONDA_PREFIX" \
  -DCMAKE_INSTALL_PREFIX="$CONDA_PREFIX" \
  -DCMAKE_INSTALL_LIBDIR="$CONDA_PREFIX/share/lfortran/lib" \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=yes \
  -G Ninja \
  .
cmake --build . --target install
