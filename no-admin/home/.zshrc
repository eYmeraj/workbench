# Managed by ~/workbench (symlinked to ~/.zshrc). Edit the file in the repo.

# HOMEBREW (user-level, no admin)
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Apps"
export PATH="$HOME/.local/bin:$HOME/.brew/bin:$HOME/.brew/sbin:$PATH"

export EDITOR="nvim"

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

autoload -Uz compinit && compinit

# plugins: ghost text from history + valid commands turn green
source "$HOME/.brew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^f' autosuggest-accept

# aliases
alias ..="cd .."
alias add="git add ."
alias push="git push"
alias pull="git pull"
alias m="git switch main"
alias cc="claude"
alias ll="ls -la"

eval "$(starship init zsh)"

# must be sourced last
source "$HOME/.brew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# machine-local overrides (not tracked)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# case insesitive TAB
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
