#!/bin/bash

if [ -e ~/.dotfiles ]; then
    echo "User environment has already been initialized"
    return 0
fi

OS=$(uname)
macOS=false
ubuntu=false
if [[ "$OS" == 'Darwin' ]]; then 
    macOS=true
elif [[ "$OS" == 'Linux']]
    ubuntu=true 
    source ~/dotfiles/ubuntu/functions.zsh
else
    echo "Exiting due to unrecognized OS: $OS"
    exit 1
fi

# Homebrew
if $macOS  && ! which brew >/dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    #for app in "${apps[@]}"; do
     #   brew cask install --appdir=/Applications $app >/dev/null
    #done
fi

# Apt
if $ubuntu; then sudo chown -R /var/lib/dpkg /var/apt/cache; fi

programs=(
awscli
docker
docker-compose
git
npm
zsh
zsh zsh-completions
zsh-syntax-highlight
)

apps=(
docker
firefox
google-chrome
intellij-idea
slack
spotify
visual-studio-code
)

# Zsh (oh-my-zsh)
if [[ "$0" != 'zsh' ]]; then chsh -s $(which zsh); fi
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Git 
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global

# Go
mkdir ~/go

# Java

# Node.js (nvm, npm)
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
nvm install v4.3 --lts # AWS Lambda
nvm install v6.9 --lts
nvm use node 

npm_pkgs=(grunt bower)
for pkg in "${npm_pkgs[@]}"; do
  npm install -g $pkg
done

# Visual Studio Code
if $ubuntu; then 
    vscode-download && deb-install ~/Downloads/vscode.deb
fi

vscode_exts=(
    lukehoban.Go
    rebornix.Ruby
    robertohuertasm.vscode-icons
)

for ext in "${vscode_exts[@]}"; do
    code --install-extension "$ext"
done

source $ZSH/oh-my-zsh.sh
