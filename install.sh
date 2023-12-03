#!/bin/bash

macOS="macOS"
ubuntu="ubuntu"
uname=$(uname -v)

case $uname in
  *Darwin*)
    os=$macOS
    ;;
  *Ubuntu*)
    os=$ubuntu
    ;;
  *)
    echo "ERROR: Don't know how to handle this OS"
    exit 1
esac

verifyPrivateFileExists() {
  if [[ ! -f "$HOME/.private" ]]; then
    echo "$HOME/.private file must be present to continue..."
    exit 1
  fi
}

installHomebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -d "/opt/homebrew" ]; then 
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  else
    brew update
  fi
}

setupDotFiles() {
  (cd "$HOME"/.dotfiles || exit; bash dotfiles.sh)
}

installRust() {
  if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path
  else
    rustup update
  fi
}

installHomebrewPackages() {
  case $os in
    $macOS*)
      echo -e "Make sure you've launched the Mac App Store and signed into your accounts!"
      echo -e "Type 'done' when you're ready to continue."
      read -r confirm
      if [ "$confirm" != "done" ] ; then
        echo "Glad I asked! Bye."
        exit 1
      else
        ##Accept xcode license for multiple items in homebrew
        sudo xcodebuild -license accept
        brew bundle
      fi
      ;;
    $ubuntu*)
      sudo timedatectl set-timezone America/Chicago
      sudo apt-get -y update
      sudo apt dist-upgrade -y
      sudo apt auto-remove -y
      ;;
  esac

  brew cleanup
}

miscellaneous() {
  yabai --install-service >/dev/null 2>&1;
  skhd --install-service >/dev/null 2>&1;
  yabai --restart-service
  skhd --restart-service
  yes | "$(brew --prefix)"/opt/fzf/install >/dev/null 2>&1;
}

echo ""
echo "Running installation for $os..."
echo ""

verifyPrivateFileExists
installHomebrew
installHomebrewPackages
setupDotFiles
installRust
miscellaneous

echo ""
echo "Done! You'll probably need to restart your shell/SSH session..."
echo ""
