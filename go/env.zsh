if [[ $(uname) == 'Darwin' ]]; then
    # symlink homebrew's GOROOT to default GOROOT
    ln -s /usr/local/opt/go/libexec /usr/local/go 
fi

export GOPATH=$HOME/go
export PATH=$GOROOT/bin:$PATH