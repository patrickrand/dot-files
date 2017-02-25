golang-download() {
    DOWNLOAD_DIR=/tmp/golang
    mkdir -p $DOWNLOAD_DIR
    cd $DOWNLOAD_DIR

    echo "Fetching latest Go version..."
    typeset VER=`curl -s https://golang.org/dl/ | grep -m 1 -o 'go\([0-9]\)\+\(\.[0-9]\)\+'`
    if uname -m | grep 64 > /dev/null; then
        typeset ARCH=amd64
    else
        typeset ARCH=386
    fi
    if [ $(uname) == 'Linux' ]; then 
        typeset FILE=$VER.linux-$ARCH
    else
        typeset FILE=$VER.darwin-$ARCH
    fi

    if [[ ! -e ${FILE}.tar.gz ]]; then
         echo "Downloading '$FILE' ..."
         wget https://storage.googleapis.com/golang/${FILE}.tar.gz 
    fi

    echo "Installing ${FILE} ..."
    sudo tar -C /usr/local -xzf ${FILE}.tar.gz
    echo "Successfully installed $FILE"
    cd -
}