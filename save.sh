#!/bin/bash

set -e

repo=~/dot-files

if [ -z "$1" ]; then
    echo "Destination directory is required"
    exit 1
fi

dir=$repo/$1
if [ ! -d "$dir" ]; then
    echo "Destination directory $dir does not exist"
    exit 1
fi

files=(
    .asoundrc
    .bash_profile
    .bashrc
    .config/Code/User/settings.json
    .config/fontconfig/fonts.conf
    .config/terminator/config
    .gitconfig
    .i3/config
    .i3status.conf
    .vimrc
    .editorconfig
    .xinitrc
    .zshrc
)

echo "Saving dot-files into $dir/..."
for f in "${files[@]}"; do
    dest=$dir/$f
    mkdir -p $(dirname $dest)
    cp ~/$f $dest
    echo $dest
done

if [[ $(uname) == 'Linux' ]]; then
  echo "Snapshotting pacman package list..."
  pacman -Q -e > ${repo}/backups/${1}.pacman
fi
