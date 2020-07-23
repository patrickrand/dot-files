#!/bin/bash

if [ -e ~/.dotfiles ]; then
    echo "User environment has already been initialized"
#    return 0
fi

macOS=false
ubuntu=false
case $(uname) in
    Darwin)       
        macOS=true
        source ~/dotfiles/macOS/functions.zsh
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install caskroom/cask/brew-cask wget htop httpie iterm2
        ;;
    Linux)
        ubuntu=true
        source ~/dotfiles/ubuntu/functions.zsh
        sudo apt-get update
        sudo apt-get install wget
        ;;            
    *) echo "Exiting due to unrecognized OS: $(uname)" && exit 1            
esac 

# Git 
if $ubuntu; then
    sudo apt-add-repository ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install git
else
    brew install git
fi
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore_global ~/.gitignore_global

# Zsh (oh-my-zsh)
[[ "$0" != 'zsh' ]] && chsh -s $(which zsh)
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ln -sf ~/dotfiles/oh-my-zsh/patrickr.zsh-theme ~/.oh-my-zsh/themes/patrickr.zsh-theme

# Pip (python)
[[ $ubuntu ]] && sudo apt-get install python-pip || brew install pip

# Go
mkdir -p ~/go/src ~/go/pkg ~/go/bin
source ~/dotfiles/golang/functions.zsh
golang-download

# Docker 
if $ubuntu; then 
    sudo apt-get install docker 
    sudo pip install docker-compose
else
    brew install docker docker-compose
fi

# AWS
[[ $ubuntu ]] && sudo apt-get install awscli || brew install awscli

# nvm (Node.js)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # Load nvm
nvm install v4.3 --lts # required for AWS Lambda
nvm install v6.9 --lts
nvm install v7 --lts
[[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]] && git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# npm (Node.js)
[[ $ubuntu ]] && sudo apt-get install npm || brew install npm
npm_pkgs=(grunt bower)
for pkg in "${npm_pkgs[@]}"; do
  sudo npm install -g $pkg
done

# Maven
if $ubuntu; then 
    sudo apt-get install maven
else
    brew install maven
fi

# Vim
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc

# Visual Studio Code
if $ubuntu; then 
    vscode-download && deb-install ~/Downloads/vscode.deb
    ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
else
    cask-install visual-studio-code
    ln -sf ~/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
fi

vscode_exts=(
    HookyQR.beautify
    PeterJausovec.vscode-docker
    lukehoban.Go
    mauve.terraform
    rebornix.Ruby
    redhat.java
    robertohuertasm.vscode-icons
)
for ext in "${vscode_exts[@]}"; do
    code --install-extension "$ext"
done

# Applications
apps=(
    docker
    firefox
    google-chrome
    intellij-idea
    slack
    spotify
)
for app in "${apps[@]}"; do
    if $ubuntu; then
        echo "Install app: $app"
    else
        # BUGGGG
        cask-install $app
    fi
done

# Fonts
if $ubuntu; then
    echo "Installing Go fonts..."
    go get github.com/golang/image
    sudo cp -r ~/go/src/github.com/image/font/gofont/ttfs/*.ttf /usr/local/share/fonts
    sudo fc-cache -fv

    echo "Installing Consolas fonts..."
    sudo apt-get install font-manager cabextract
    mkdir -p /tmp/fonts
    cd /tmp/fonts
    wget http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
    cabextract -L -F ppviewer.cab PowerPointViewer.exe
    cabextract ppviewer.cab
    echo "Execute 'font-manager' to install MS fonts..."
fi

# XTerm
if $ubuntu; then 
    sudo apt-get install xterm
    sudo update-alternatives --config x-terminal-emulator
else
    cask-install xterm
fi
ln -sf ~/dotfiles/xterm/Xresources ~/.Xresources
xrdb -merge ~/.Xresources

# Finish
ln -sf ~/dotfiles/zshrc ~/.zshrc
touch ~/.dotfiles
echo "System configuration complete. Source '.zshrc' to finish."
