deb-install() {
    if [ -z "$1" ]; then
        echo "Debian package is required"
        exit 1
    fi

    dpkg -i $1 && apt-get install -f
}

vscode-download() {
    rm ~/Downloads/vscode.deb
    curl -L -o ~/Downloads/vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
}
