#!/bin/bash

# if [ -e ~/.dotfiles ]; then
#     echo "User environment has already been initialized"
#     return 0
# fi

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
        # sudo apt-get update
        ;;            
    *) echo "Exiting due to unrecognized OS: $(uname)" && exit 1            
esac 

# # Git 
# if $ubuntu; then
#     sudo apt-add-repository ppa:git-core/ppa
#     sudo apt-get update
#     sudo apt-get install git
# else
#     brew install git
# fi
# ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
# ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global


# # Zsh (oh-my-zsh)
# [[ $ubuntu ]] && sudo apt-get install zsh || brew install zsh
# if [[ ! -d ~/.oh-my-zsh ]]; then
#     sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# fi

# Go
# mkdir ~/go

# [[ $ubuntu ]] && sudo apt-get install python-pip || brew install pip


# # Docker 
# if $ubuntu; then 
#     sudo apt-get install docker 
#     sudo pip install docker-compose
# else
#     brew install docker docker-compose
# fi
# AWS
# [[ $ubuntu ]] && sudo apt-get install awscli || brew install awscli

# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
# nvm install v4.3 --lts # AWS Lambda
# nvm install v6.9 --lts
# [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]] && git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
# [[ $ubuntu ]] && sudo apt-get install npm || brew install npm
# npm_pkgs=(grunt bower)
# for pkg in "${npm_pkgs[@]}"; do
#   sudo npm install -g $pkg
# done

# ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

# vscode_exts=(
#     lukehoban.Go
#     rebornix.Ruby
#     robertohuertasm.vscode-icons
# )
# for ext in "${vscode_exts[@]}"; do
#     code --install-extension "$ext"
# done

# sudo apt-get install wget font-manager cabextract
# mkdir /tmp/fonts
# cd /tmp/fonts
# wget http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
# cabextract -L -F ppviewer.cab PowerPointViewer.exe
# cabextract ppviewer.cab
# echo "Execute 'font-manager' to install MS fonts..."

ln -sf ~/dotfiles/zshrc ~/.zshrc
. ~/.zshrc