# shellcheck shell=bash
# shared helpers, sourced by every step
# shellcheck disable=SC2034  # KIT is used by the scripts that source this file
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log() { printf '\033[35m==>\033[0m %s\n' "$*"; }

# standard Homebrew prefix: /opt/homebrew on Apple Silicon, /usr/local on Intel
brew_shellenv() {
  local b
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$b" ]; then "$b" shellenv; return; fi
  done
}
eval "$(brew_shellenv)"
# marksman and the agent tools install into ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# link SRC DEST: symlink DEST -> SRC, backing up any real file already there
# (an existing symlink holds no data, so it is just replaced, e.g. after moving this repo)
link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "   ok      $dest"; return
  fi
  if [ -L "$dest" ]; then
    rm "$dest"; echo "   relink  $dest"
  elif [ -e "$dest" ]; then
    local bak; bak="$dest.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$bak"; echo "   backup  $dest -> $bak"
  fi
  ln -s "$src" "$dest"; echo "   linked  $dest -> $src"
}
