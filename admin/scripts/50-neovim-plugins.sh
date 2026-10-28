#!/usr/bin/env bash
# Pre-install Neovim plugins (lazy.nvim, pinned by lazy-lock.json) so first launch is instant.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
log "Syncing Neovim plugins"
nvim --headless "+Lazy! restore" +qa
