# Managed by ~/workbench (symlinked to ~/.zshrc). Edit the file in the repo.

# HOMEBREW (standard prefix: /opt/homebrew on Apple Silicon, /usr/local on Intel)
for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$b" ] && eval "$("$b" shellenv)" && break
done
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

autoload -Uz compinit && compinit

# plugins: ghost text from history + valid commands turn green
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
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
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# machine-local overrides (not tracked)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# case insesitive TAB
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
