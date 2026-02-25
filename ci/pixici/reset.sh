#!/usr/bin/env bash

set -e

echo "Running SHELL"

rm -rf ../lf/pixi.lock && rm -rf ../lf/.pixi
cp ../lf/pixi.toml pixi.toml.bak
cp ./setvars.* ../lf
cp ./pixi.toml.blank ../lf/pixi.toml && cd ../lf

pixi import ../environment_linux.yml -p linux-64 -f envx
pixi import ../../environment_win.yml -p win-64 -f envw

pixi task add clean "bash clean.sh" --cwd ../../ -p linux-64 -f envx
pixi task add ci "bash ./ci/build.sh" --cwd ../../ -p linux-64 -f envx --depends-on clean

pixi task add clean "xonsh clean.sh" --cwd ../../ -p win-64 -f envw
pixi task add ci "xonsh ./ci/build.sh" --cwd ../../ -p win-64 -f envw --depends-on clean

# Unix dependencies
pixi remove -p linux-64 -f envx llvmdev
pixi remove -p linux-64 -f envx zstd-static
pixi add -p linux-64 -f envx zstd-static
pixi add -p linux-64 -f envx llvmdev==21.1.8
pixi upgrade -f envx
pixi add -p linux-64 -f envx python==3.13.12

# Windows dependencies
pixi remove -p win-64 -f envw llvmdev
pixi add -p win-64 -f envw llvmdev==21.1.8
pixi add -p win-64 -f envw pandoc
pixi upgrade -f envw
pixi add -p win-64 -f envw python==3.13.12

pixi workspace description set "Modern interactive LLVM-based Fortran compiler"
version=$(git describe --tags --abbrev=0) && pixi workspace version set "${version:1}"

pixi update

echo "Change to directory $(pwd) and execute: <pixi run -e envx ci> "
