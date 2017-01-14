CURR_DIR=$(pwd)
OS=$(uname)
macOS=false
arch_linux=false
if [ "$OS" == "Darwin" ]; then macOS=true; else arch_linux=true; fi

# Zsh
#if [ $(echo $0) != 'zsh' ]; then chsh -s /usr/local/bin/zsh; fi

# Environment Variables
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export EDITOR='vim'
export GOPATH=$HOME/go
export JAVA_HOME=/usr/java/jdk1.8.0_11
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:$PATH:$GOPATH/bin:$JAVA_HOME/bin

# Homebrew
if $macOS  && ! which brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install zsh zsh-completions
fi

# Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ZSH_THEME="bureau"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]; then
  git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
fi

plugins=(git zsh-nvm)
source $ZSH/oh-my-zsh.sh

# Functions
if $arch_linux; then
  function rwifi() {
      case "$1" in
          cypress)
              x=ATT5m396n8
              ;;
          tao)
              x=NETGEAR71-5G
              ;;
          *)
              echo "Invalid wifi interface $1"
              exit 1
              ;;
      esac
      sudo netctl restart wlp3s0-${x}
  }

  function lite() {
    xbacklight -set $1
  }

  function vol() {
    amixer set Master ${1}%
  }

  function update-vscode() {
    mkdir -p ~/aur
    cd ~/aur
    curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/visual-studio-code.tar.gz
    tar xzvf visual-studio-code.tar.gz && rm -rf visual-studio-code.tar.gz
    cd visual-studio-code && makepkg -sri && rm -rf *.tar.*
    cd $CURR_DIR
  }
fi

function dropmic() {
  docker rm -f $(docker ps -a -q)
  docker rmi -f $(docker images ps -q)
  docker volume rm $(docker volume ls -q)
}

# Visual Studio Code
if ! which code >/dev/null 2>&1; then
  if $macOS; then
    brew install visual-studio-code
  else
    update-vscode
  fi

  declare -a vscode_exts=(
    lonefy.vscode-JS-CSS-HTML-formatter
    lukehoban.Go
    mohsen1.prettify-json
    rebornix.Ruby
    robertohuertasm.vscode-icons
  )

  for i in "${exts[@]}"; do
    code --install-extension "$i"
  done
fi


# SSH agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval $(ssh-agent)
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# DPMS workaround (hibernation issue)
if [ $arch_linux ];then xset s off && xset -dpms; fi
