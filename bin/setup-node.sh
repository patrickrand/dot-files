#!/bin/bash

git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
source ~/.zshrc # assuming plugins=(zsh-nvm)
# source ~/.zsh-nvm/zsh-nvm.plugin.zsh
nvm install v6.9 --lts


