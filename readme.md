
# dotfiles

Included here are config files to set up a system to my preferences. It includes configuration for vscode, zsh, git, and macOS.

## Installation

Clone this repo and `cd` into it.

```shell
    git clone git@github.com:jlsherrod/dotfiles ~/.dotfiles
    cd ~/.dotfiles
```

Install software & dotfiles:

```shell
    ./install.sh
```

This will install all key bits of software I use for development (some of which these dotfiles rely on) as well as configurations I find handy for macOS.

## Maintenance

The `install.sh` script can be run anytime to update the same set of tools.

The `dotfiles.sh` script can be run anytime to reload and add new dotfiles. It gets run at the end of installs. It will prompt you before it does anything destructive.

**Note**: If you copy this repo please change the `gitconfig` file to use your name and email rather than mine. 
