# Environment Variables
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export EDITOR='vim'
export GOPATH=$HOME/go
export GOROOT=/usr/local/go

# Path
export PATH=/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:/bin:/sbin
export PATH=$GOROOT/bin:$PATH

# Oh-My-Zsh 
ZSH_THEME="bureau"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-nvm)
source $ZSH/oh-my-zsh.sh

# SSH agent
#if [ ! -S ~/.ssh/ssh_auth_sock ]; then
 #   eval $(ssh-agent)
  #  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
#fi
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#ssh-add -l > /dev/null || ssh-add

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load dotfiles
for file in ~/dotfiles/**/**.zsh; do
    source $file
done
