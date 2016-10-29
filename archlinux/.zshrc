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
alias github="cd $GOAPTH/github.com"
alias dropper='docker rm -f $(docker ps -a -q)'

# Scala
export SCALA_HOME=/usr/local/share/scala
export PATH=$PATH:$SCALA_HOME/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Java 
JAVA_HOME=/usr/java/jdk1.8.0_11
PATH=$PATH:$JAVA_HOME/bin

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

