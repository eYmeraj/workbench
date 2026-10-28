#!/usr/bin/env bash
# Install user-level Homebrew into ~/.brew if missing (no admin needed).
set -euo pipefail; source "$(dirname "$0")/lib.sh"
if [ -x "$HOME/.brew/bin/brew" ]; then
  log "Homebrew already at ~/.brew"
else
  log "Installing Homebrew into ~/.brew (untar method, no sudo)"
  mkdir -p "$HOME/.brew"
  curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C "$HOME/.brew"
fi
mkdir -p "$HOME/Apps"
brew update --quiet || true
