#!/bin/bash

brew install rcm

cd "$HOME" || exit

echo ""
echo "Installing dot files..."
echo ""

rcup -v -x "*.sh" -x "*.md" -x "iterm/com*"

# must symlink the directory for these apps
ln -sf "$HOME"/.dotfiles/iterm "$HOME"/.config