# shellcheck shell=bash
# shared helpers, sourced by every step
# shellcheck disable=SC2034  # KIT is used by the scripts that source this file
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Apps"
export PATH="$HOME/.local/bin:$HOME/.brew/bin:$HOME/.brew/sbin:$PATH"
log() { printf '\033[35m==>\033[0m %s\n' "$*"; }

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
