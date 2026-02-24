#!/usr/bin/env bash

set -e

echo "Running SHELL"

rm -rf ../lfortran/pixi.lock && rm -rf ../lfortran/.pixi
cp ../lfortran/pixi.toml pixi.toml.bak && cp setvars.* ../lfortran
cp pixi.toml.blank ../lfortran/pixi.toml && cd ../lfortran

pixi import ../environment_linux.yml -p linux-64 -f envx
pixi import ../../environment_win.yml -p win-64 -f envw

pixi task add clean "bash clean.sh" --cwd ../../ -p linux-64 -f envx
pixi task add ci "bash ./ci/build.sh" --cwd ../../ -p linux-64 -f envx --depends-on clean

pixi task add clean "xonsh clean.sh" --cwd ../../ -p win-64 -f envw
pixi task add ci "xonsh ./ci/build.sh" --cwd ../../ -p win-64 -f envw --depends-on clean

# Unix dependencies
pixi remove zstd-static -f envx -p linux-64
pixi remove llvmdev -f envx -p linux-64
pixi remove numpy -f envx -p linux-64

pixi add -p linux-64 -f envx python=3.13
pixi add -p linux-64 -f envx numpy
pixi add -p linux-64 -f envx gcc=15.2 gxx=15.2
pixi add -p linux-64 -f envx libunwind=1.7.2
pixi add -p linux-64 -f envx zstd-static=1.5.7
pixi add -p linux-64 -f envx cmake==4.2.3
pixi add -p linux-64 -f envx llvmdev==21.1.8
:
# Windows dependencies
pixi remove numpy -f envw -p win-64
pixi remove llvmdev -f envw -p win-64
pixi remove xonsh -f envw -p win-64

pixi add -p win-64 -f envw python=3.13
pixi add -p win-64 -f envw xonsh
pixi add -p win-64 -f envw numpy
pixi add -p win-64 -f envw clang==21.1.8
pixi add -p win-64 -f envw cmake=4.2.3
pixi add -p win-64 -f envw llvmdev==21.1.8

pixi workspace description set "Modern interactive LLVM-based Fortran compiler"
version=$(git describe --tags --abbrev=0) && pixi workspace version set "${version:1}"

pixi update

echo "Change to directory $(pwd) and execute: <pixi run -e envx ci> "
