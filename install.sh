#!/bin/bash

source utils.sh

createPrivateFiles() {
	touch "$HOME"/.private
}

installGit() {
	installOrUpdate "git"
}

installLazygit() {
  case $os in
    $macOS*)
      installOrUpdate "jesseduffield/lazygit/lazygit"
      ;;
  esac
}

installRust() {
  if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path
  else
    rustup update
  fi
}

installKarabinerElements() {
  case $os in
    $macOS*)
      installOnceFromCask "karabiner-elements"
      ;;
  esac
}

installDropbox() {
  case $os in
    $macOS*)
      installOnceFromCask "dropbox"
      ;;
  esac
}

installZsh() {
  installOrUpdate "zsh"

  if [[ $SHELL != *zsh* ]]; then
    sudo chsh -s "$(command -v zsh)" "$(whoami)"
  fi
}

installZshSyntaxHighlighting() {
  installOrUpdate "zsh-syntax-highlighting"
}

installZoxide() {
  installOrUpdate "zoxide"
}

installReadline() {
  case $os in
    $macOS*)
      installOrUpdate "readline"
      ;;
    $ubuntu*)
      installOrUpdate "readline8"
      ;;
  esac
}

installLess() {
  installOrUpdate "less"
}

installFzf() {
  installOrUpdate "fzf"
}

installRg() {
  case $os in
    $macOS*)
      installOrUpdate "ripgrep"
      ;;
    $ubuntu*)
      # https://github.com/sharkdp/bat/issues/938
      sudo apt -y install -o Dpkg::Options::="--force-overwrite" ripgrep
      ;;
  esac

}

installGh() {
  case $os in
    $macOS*)
      installOrUpdate "gh"
      ;;
    $ubuntu*)
      if ! command -v gh >/dev/null 2>&1; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        updateAvailablePackages
      fi

      installOrUpdate "gh"

      gh completion -s zsh | sudo tee /usr/local/share/zsh/site-functions/_gh > /dev/null
      ;;
  esac

  gh extension install dlvhdr/gh-dash
}

installTerminal() {
  case $os in
    $macOS*)
      installOnceFromCask "iterm2"
      ;;
  esac
}

installWindowManager() {
  case $os in
    $macOS*)
      if ! command -v yabai >/dev/null 2>&1; then
        installOrUpdate "koekeishiya/formulae/yabai"

        echo -e "You need to disable SIP and do some other hackery to get this loading on macOS"
        echo -e "https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)"
        echo -e "Type 'OK' to acknowledge this!"
        read -r confirm
        if [ "$confirm" != "OK" ] ; then
          echo "Get it done! Exiting."
          exit 1
        fi
      else
        brew services stop yabai
        brew upgrade yabai
        brew services start yabai

        sudo yabai --uninstall-sa
        sudo yabai --install-sa

        killall Dock
      fi
      ;;
  esac
}

installTree() {
  installOrUpdate "tree"
}

installWget() {
  installOrUpdate "wget"
}

installTrash() {
  case $os in
    $macOS*)
      installOrUpdate "trash"
      ;;
  esac
}

installBottom() {
  case $os in
    $macOS*)
      installOrUpdate "bottom"
      ;;
  esac
}

installBandwhich() {
  case $os in
    $macOS*)
      installOrUpdate "bandwhich"
      ;;
  esac
}

installNeovim() {
  case $os in
    $macOS*)
      installOrUpdate "neovim"
      ;;
    $ubuntu*)
      if ! command -v nvim >/dev/null 2>&1; then
        sudo snap install nvim --classic
      else
        sudo snap refresh nvim --classic
      fi

      ;;
  esac
}

setupNeovim() {
  mkdir -p "$HOME"/.config/nvim/

  if [ ! -f "$HOME"/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    pip3 install neovim
    yarn global add neovm
  else
    pip3 install neovim --upgrade
    yarn global upgrade neovm
  fi

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

echo ""
echo "Running installation for $os..."
echo ""

createPrivateFiles
installGh
installGit
installLazygit
installRust
installKarabinerElements
installDropbox
installZsh
installZshSyntaxHighlighting
installZoxide
installReadline
installLess
installFzf
installRg
installGh
installTerminal
installWindowManager
installTree
installWget
installTrash
installBottom
installBottom
installBandwhich
installNeovim
setupNeovim
cleanupPackages

echo ""
echo "Done! You'll probably need to restart your shell/SSH session..."
echo ""
