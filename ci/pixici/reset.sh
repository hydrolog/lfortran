#!/usr/bin/env bash

set -ex

export LFORTRAN_CMAKE_GENERATOR=Ninja

echo "Running SHELL"
echo "CONDA_PREFIX=$CONDA_PREFIX"
echo "LFORTRAN_CMAKE=$LFORTRAN_CMAKE_GENERATOR"

rm -rf ../lfortran && mkdir -p ../lfortran && cp pixi.toml ../lfortran/pixi.toml
cp ../../setvars.* .
cp setvars.* ../lfortran
cd ../lfortran

pixi import ../environment_linux.yml -p linux-64 -f unix
pixi add -p linux-64 -f unix libunwind=1.7.2
pixi import ../../environment_win.yml -p win-64 -f windows

../version.sh && pixi workspace version set $(cat version)

pixi workspace description set "Modern interactive LLVM-based Fortran compiler"

pixi task add clean "git clean -dfx -e '.pixi'" -p linux-64 -f unix

pixi task add ci "./ci/build.sh" --cwd ../../ --depends-on clean -p linux-64 -f unix

pixi update

