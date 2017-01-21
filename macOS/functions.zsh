cask-install() {
    if [ -z "$1" ]; then
        echo "Homebrew package is required"
        exit 1
    fi
    brew cask install --appdir=/Applications $1 
}