#!/usr/bin/env bash
# Install CLI tools, WezTerm, Claude Code and Hack Nerd Font from the Brewfile.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
log "brew bundle"
brew bundle --file="$KIT/Brewfile"
