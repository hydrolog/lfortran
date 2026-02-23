#!/usr/bin/env bash

set -e
set -x

#emsdk update
#emsdk install latest
#emsdk activate latest

export EMSDK_PATH=${EMSDK}

export CXXFLAGS="${CXXFLAGS} -D__STDC_FORMAT_MACROS -D_LIBCPP_DISABLE_AVAILABILITY"
version=$(git describe --tags --abbrev=0)
version="${version:1}"
echo $version >version

echo $version >version

export LFORTRAN_CC=${CC}
cmake -S ${SRC_DIR} -B ./${SRC_DIR}/build \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_FLAGS_RELEASE="-Wall -Wextra -O3 -funroll-loops -DNDEBUG" \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DWITH_LLVM=yes \
  -DWITH_LLVM_STACKTRACE=no \
  -DWITH_LSP=yes \
  -DWITH_XEUS=yes \
  -DWITH_RUNTIME_LIBRARY=yes \
  -DWITH_RUNTIME_STACKTRACE=yes \
  -DWITH_TARGET_WASM=no \
  -DCMAKE_INSTALL_LIBDIR=share/lfortran/lib \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=yes
-G Ninja

cmake --build ./${SRC_DIR}/build --target install

#echo "FIND CONFIG FILE"
#find . -iname "*config.h"

#make -j${CPU_COUNT}
#make install
#if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == 1 ]]; then
#  cp ../build-native/src/runtime/*.mod $PREFIX/share/lfortran/lib/
#fi
