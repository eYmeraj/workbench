#!/usr/bin/env bash
# Agent tools: no-mistakes (validation pipeline) and treehouse (worktree pool).
# ~/.local/bin is on PATH first so both installers skip sudo.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
mkdir -p "$HOME/.local/bin"
log "Installing no-mistakes"
curl -fsSL https://raw.githubusercontent.com/kunchenguid/no-mistakes/main/docs/install.sh | sh
log "Installing treehouse"
curl -fsSL https://kunchenguid.github.io/treehouse/install.sh | sh
