#!/usr/bin/env bash

set -e

echo "Running SHELL"
echo "CONDA_PREFIX=$CONDA_PREFIX"

rm -rf ../lfortran/pixi.lock && rm -rf ../lfortran/.pixi
cp ../lfortran/pixi.toml pixi.toml.bak && cp setvars.* ../lfortran
cp pixi.toml.blank ../lfortran/pixi.toml && cd ../lfortran

pixi import ../environment_linux.yml -p linux-64 -f unix
pixi import ../../environment_win.yml -p win-64 -f windows

pixi task add ci "./ci/build.sh" --cwd ../../ -p linux-64 -f unix

# Linux dependencies
pixi remove zstd-static -f unix -p linux-64 
pixi remove llvmdev -f unix -p linux-64
pixi add -p linux-64 -f unix libunwind=1.7.2
pixi add -p linux-64 -f unix zstd-static=1.5.7
pixi add -p linux-64 -f unix cmake=3.29.1 
pixi add -p linux-64 -f unix llvmdev==21.1.2

# Windows dependencies
pixi remove llvmdev -f windows -p win-64
pixi add -p win-64 -f windows cmake=4.2.1
pixi add -p win-64 -f windows llvmdev==21.1.2

pixi workspace description set "Modern interactive LLVM-based Fortran compiler"
pixi workspace platform add osx-64 osx-arm64
../version.sh && pixi workspace version set $(cat version)

pixi update

echo "Change to directory $(pwd) and execute: <pixi run -e unix ci> "
