#!/usr/bin/env bash
# Install Homebrew with the official installer if missing (asks for your admin password).
set -euo pipefail; source "$(dirname "$0")/lib.sh"
if command -v brew >/dev/null; then
  log "Homebrew already at $(brew --prefix)"
else
  log "Installing Homebrew (official installer, needs sudo)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(brew_shellenv)"
fi
brew update --quiet || true
