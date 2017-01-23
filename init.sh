#!/bin/bash

if [ -e ~/.dotfiles ]; then
    echo "User environment has already been initialized"
    return 0
fi

macOS=false
ubuntu=false
case $(uname) in
    Darwin)       
        macOS=true
        source ~/dotfiles/macOS/functions.zsh
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install caskroom/cask/brew-cask
        ;;
    Linux)
        ubuntu=true
        source ~/dotfiles/ubuntu/functions.zsh
        sudo apt-get update
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

# Pip (python)
[[ $ubuntu ]] && sudo apt-get install python-pip || brew install pip

# Go
mkdir -p ~/go
if $ubuntu; then 
    # ...
else
    brew install go
    sudo ln -sf $(go env GOROOT) /usr/local/go
    sudo chown -RH $(whoami) /usr/local/go
fi

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
[[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]] && git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# npm (Node.js)
[[ $ubuntu ]] && sudo apt-get install npm || brew install npm
npm_pkgs=(grunt bower)
for pkg in "${npm_pkgs[@]}"; do
  sudo npm install -g $pkg
done

# Vim
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc

# Visual Studio Code
if $ubuntu; then 
    vscode-download && deb-install ~/Downloads/vscode.deb
else
    cask-install visual-studio-code
fi
mkdir -p ~/.config/Code/User
ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

vscode_exts=(
    lukehoban.Go
    rebornix.Ruby
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
        #...
    else
        # BUGGGG
        cask-install $app
    fi
done

# Fonts
if $ubuntu; then
    sudo apt-get install wget font-manager cabextract
    mkdir -p /tmp/fonts
    cd /tmp/fonts
    wget http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
    cabextract -L -F ppviewer.cab PowerPointViewer.exe
    cabextract ppviewer.cab
    echo "Execute 'font-manager' to install MS fonts..."
fi

# Finish
ln -sf ~/dotfiles/zshrc ~/.zshrc
touch ~/.dotfiles
echo "System configuration complete. Source '.zshrc' to finish."
