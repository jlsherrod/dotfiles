#!/bin/bash

brew install rcm

cd "$HOME" || exit

echo ""
echo "Installing dot files..."
echo ""

rcup -v -x "*.sh" -x "*.md" -x "iterm/com*" -x "config/karabiner"

# must symlink the directory for these apps
ln -sf "$HOME"/.dotfiles/iterm "$HOME"/.config
ln -sf "$HOME"/.dotfiles/config/karabiner "$HOME"/.config

echo ""
echo "Cleaning up broken symlinks..."
echo ""
find -L "$HOME" -maxdepth 1 -type l -exec rm -i {} \;
find -L "$HOME/.bin" -type l -exec rm -i {} \;
find -L "$HOME/.config" -type l -exec rm -i {} \;
find -L "$HOME/.zsh" -type l -exec rm -i {} \;
