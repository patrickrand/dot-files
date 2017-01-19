rwifi() {
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

lite() { xbacklight -set $1 }

vol() { amixer set Master ${1}% }

aur-update() {
    workdir=$(pwd)
    if [ -z "$1" ]; then
        echo "AUR package is required"
        exit 1
    fi

    pkg=$1.tar.gz

    cd ~/aur
    curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/$pkg
    tar xzvf $pkg && \
        rm -rf $pkg && \
        cd $1 && \
        makepkg -sri && \
        rm -rf *.tar.*
        cd $workdir
}