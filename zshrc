#export PS1="\u@\h \w> "
# Environment Variables
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR='vim'
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export XTERM_LOCALE=en_US.UTF-8

# export AWS_DEFAULT_PROFILE=prand
# export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
#  AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
#  AWS_DEFAULT_REGION=$(aws configure get region)

# Path
export PATH=/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:/bin:/sbin
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

# Oh-My-Zsh 
ZSH_THEME="prand"
DISABLE_AUTO_UPDATE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
unsetopt AUTO_CD # worst feature ever

# SSH agent
#if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#   eval $(ssh-agent)
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
nvm use 10 > /dev/null
export PATH=$PATH:/Users/prand/.nvm/versions/node/v8.2.1/bin/npm

# Aliases
alias cat="ccat"

[[ -f ~/.bashrc ]] && source ~/.bashrc
