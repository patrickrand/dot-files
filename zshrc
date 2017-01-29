# Environment Variables
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR='vim'
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export XTERM_LOCALE=en_US.UTF-8

# Path
export PATH=/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:/bin:/sbin
export PATH=$GOROOT/bin:$PATH

# Oh-My-Zsh 
ZSH_THEME="patrickr"
DISABLE_AUTO_UPDATE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# SSH agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
   eval $(ssh-agent)
fi
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load dotfiles
for file in ~/dotfiles/**/**.zsh; do
    source $file
done
