#!/usr/bin/env bash

set -ex

echo "Running SHELL"
echo "CONDA_PREFIX=$CONDA_PREFIX"

cp ../lfortran/pixi.toml pixi.toml.bak && cp setvars.* ../lfortran
cp pixi.toml.blank ../lfortran/pixi.toml && cd ../lfortran

pixi import ../environment_linux.yml -p linux-64 -f unix
pixi add -p linux-64 -f unix libunwind=1.7.2
pixi import ../../environment_win.yml -p win-64 -f windows

../version.sh && pixi workspace version set $(cat version)

pixi workspace description set "Modern interactive LLVM-based Fortran compiler"
pixi workspace platform add win-64 osx-64 osx-arm64

pixi task add ci "./ci/build.sh" --cwd ../../ -p linux-64 -f unix

pixi update

echo "Change to directory $(pwd) and execute: <pixi run -e unix ci> "
