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
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew install git
        brew tap homebrew/cask-versions
        brew install git npm maven python wget awscli golang cabextract
        brew cask install iterm2 corretto visual-studio-code docker google-cloud-sdk intellij-idea amethyst
        ;;
    Linux)
        ubuntu=true
        source ~/dotfiles/ubuntu/functions.zsh
        sudo apt-add-repository ppa:git-core/ppa
        sudo apt-get update
        sudo apt-get install wget git python-pip docker awscli npm maven golang
        sudo pip install docker-compose
        ;;            
    *) echo "Exiting due to unrecognized OS: $(uname)" && exit 1            
esac 

# Git
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore_global ~/.gitignore_global

# Oh-My-Zsh
[[ "$0" != 'zsh' ]] && chsh -s $(which zsh)
if [ ! -d ~/.oh-my-zsh ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ln -sf ~/dotfiles/oh-my-zsh/prand.zsh-theme ~/.oh-my-zsh/themes/prand.zsh-theme

# Go
mkdir -p ~/go/src ~/go/pkg ~/go/bin
go get github.com/jingweno/ccat

# nvm (Node.js)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # Load nvm
nvm install v10 --lts
[[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]] && git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

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
    ln -sf ~/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
fi
vscode_exts=(
    hookyqr.beautify
    golang.go
    hashicorp.terraform
    rebornix.ruby
    vscode-icons-team.vscode-icons
    vscjava.vscode-java-pack
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
        echo "Install app: $app";
        # TODO: how to handle this if already installed on work laptop for Mac?
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
else
    mkdir -p ~/Downloads/consolas
    cd ~/Downloads/consolas
    curl -LvO https://sourceforge.net/projects/mscorefonts2/files/cabs/PowerPointViewer.exe
    cabextract PowerPointViewer.exe
    cabextract ppviewer.cab
    open CONSOLA*.TTF
fi

# XTerm
if $ubuntu; then 
    sudo apt-get install xterm
    sudo update-alternatives --config x-terminal-emulator
    ln -sf ~/dotfiles/xterm/Xresources ~/.Xresources
    xrdb -merge ~/.Xresources   
fi

# Finish
ln -sf ~/dotfiles/zshrc ~/.zshrc
touch ~/.dotfiles
echo "System configuration complete. Source '.zshrc' to finish."
