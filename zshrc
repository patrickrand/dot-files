OS=$(uname)
macOS=false
arch_linux=false
if [[ "$OS" == 'Darwin' ]]; then 
    macOS=true
elif [[ "$OS" == 'Linux']]
    arch_linux=true 
else
    echo "Exiting due to unrecognized OS: $OS"
    exit 1
fi

# Environment Variables
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl

# Oh-My-Zsh variables
ZSH_THEME="bureau"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-nvm)

# SSH agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval $(ssh-agent)
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# DPMS workaround (hibernation issue)
if [ $arch_linux ];then 
    xset s off
    xset -dpms 
fi