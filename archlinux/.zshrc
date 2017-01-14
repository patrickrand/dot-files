export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl"
export LANG=en_US.UTF-8
export EDITOR='vim'

# Oh My Zsh
ZSH_THEME="bureau"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases
alias nerd="vim +NERDTree"
alias gh="cd $GOPATH/src/github.com"
alias dropper='docker rm -f $(docker ps -a -q)'

# Scala
export SCALA_HOME=/usr/local/share/scala
export PATH=$PATH:$SCALA_HOME/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Java 
export JAVA_HOME=/usr/java/jdk1.8.0_11
export PATH=$PATH:$JAVA_HOME/bin

# Yahoo Developer Network
export YDN_KEY=dj0yJmk9T3gyeTQ5czZzcFcyJmQ9WVdrOVltSjBkSEJITm1VbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1kNw--
export YDN_SECRET=993643edd51a3df6ec463f4616fe2f7b65a23d60

# Functions
function rwifi() {
    case "$1" in
        cypress)
            x=ATT5m396n8
            ;;
        tao)
            x=NETGEAR71-5G
            ;;
        *)
            echo "Invalid wifi interface"
            ;;
    esac
    echo "Restarting $1 wifi interface..."
    sudo netctl restart wlp3s0-${x}
}

function lite() {
	xbacklight -set $1
}

function vol() {
	amixer set Master ${1}%
}

# DPMS workaround
xset s off 
xset -dpms

# SSH agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add


