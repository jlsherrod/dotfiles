export ZSH="$HOME/.oh-my-zsh"
export EDITOR="code"
export VISUAL="code"

ZSH_THEME="robbyrussell"

plugins=()

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/functions

# Add fzf 'fuzzy find' 
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh