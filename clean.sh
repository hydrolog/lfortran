#!/usr/bin/env bash

set -e
set -x

if [[ $1 == "" ]]; then
  echo "Clean all"
  echo "This will erase build artifacts and uncommited edits."
  read -p "Are you sure? (Y/n): " -n 1 -r
  echo # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi
  echo "Action confirmed. Continuing..."
  echo "Erasing all build artifacts ..."
  git clean -dfx -e '.pixi'
else
    echo "Invalid option"
    exit 1
fi

echo "Clean succeeded"

exit 0
