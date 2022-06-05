export EDITOR="code"
export VISUAL="code"

eval "$(starship init zsh)"

source $HOME/.zsh/completion
source $HOME/.zsh/functions

# Add fzf 'fuzzy find' 
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
