#!/bin/bash

set -e -x

cd ~/aur

curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/visual-studio-code.tar.gz 

tar xzvf visual-studio-code.tar.gz && rm -rf visual-studio-code.tar.gz

cd visual-studio-code && makepkg -sri && rm -rf *.tar.*


