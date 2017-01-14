#!/bin/bash

declare -a exts=(
    lonefy.vscode-JS-CSS-HTML-formatter
    lukehoban.Go
    mohsen1.prettify-json
    rebornix.Ruby
    robertohuertasm.vscode-icons
)

for i in "${exts[@]}"; do
    code --install-extension "$i"
done

