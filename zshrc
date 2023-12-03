export EDITOR="nvim"
export VISUAL="code"
alias vim="nvim"

eval "$(starship init zsh)"

source $HOME/.zsh/completion
source $HOME/.zsh/functions

# Add fzf 'fuzzy find' 
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Create 'e' alias for fzf and fancy file finding
alias e="fd --type f --hidden --exclude .git | fzf | xargs nvim"

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Install zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 

#Pyenv config to ensure python3 as default
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


