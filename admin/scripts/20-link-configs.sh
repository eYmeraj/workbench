#!/usr/bin/env bash
# Symlink configs from this repo into $HOME, so edits here take effect immediately.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
H="$KIT/home"
log "Linking configs"
link "$H/.zshrc"                  "$HOME/.zshrc"
link "$H/.config/starship.toml"   "$HOME/.config/starship.toml"
link "$H/.config/wezterm"         "$HOME/.config/wezterm"
link "$H/.config/nvim"            "$HOME/.config/nvim"
link "$H/.claude/settings.json"   "$HOME/.claude/settings.json"
# one shared agent policy for every harness
link "$H/AGENTS.md"               "$HOME/.claude/CLAUDE.md"
link "$H/AGENTS.md"               "$HOME/.codex/AGENTS.md"
link "$H/AGENTS.md"               "$HOME/.config/opencode/AGENTS.md"
