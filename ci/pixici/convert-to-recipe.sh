#!/usr/bin/env bash
# Script to convert conda meta.yaml to recipe.yaml for rattler-build processing
# Requires conda-recipe-manager

set -ex

echo "Running SHELL"
echo "CONDA_PREFIX=$CONDA_PREFIX"
conda-recipe-manager convert meta.yaml > recipe.yaml

echo "Please, edit recipe.yaml to adjust for local building."  

echo "Fineshed!"

