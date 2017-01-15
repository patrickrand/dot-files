#!/bin/bash

set -e

repo=~/dot-files

if [ -z "$1" ]; then
    echo "Source directory is required"
    exit 1
fi

dir=$repo/$1
if [ ! -d "$dir" ]; then
    echo "Source directory $dir does not exist"
    exit 1
fi

echo "Loading dot-files from $dir/..."
cp -r -v $dir/. ~/
