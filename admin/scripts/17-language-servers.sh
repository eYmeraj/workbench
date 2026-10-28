#!/usr/bin/env bash
# Install or update every language server Neovim enables (home/.config/nvim/lua/plugins/lsp.lua).
# Re-run on its own with: ./install.sh 17. sourcekit-lsp for Swift ships with Xcode.
set -euo pipefail; source "$(dirname "$0")/lib.sh"

log "Language servers from Homebrew: lua_ls, xcode-build-server (Swift), shellcheck (bashls diagnostics)"
brew install --quiet lua-language-server xcode-build-server shellcheck

log "Language servers from npm: vtsls, pyright, html/cssls/jsonls, tailwindcss, bashls, yamlls"
# --ignore-scripts: none of these need install scripts (only core-js has one, a donation banner)
npm install --global --no-fund --no-audit --ignore-scripts \
  @vtsls/language-server pyright vscode-langservers-extracted \
  @tailwindcss/language-server bash-language-server yaml-language-server

# marksman's brew formula pulls in the whole .NET runtime; the release binary is self-contained
latest="$(curl -fsSL https://api.github.com/repos/artempyanykh/marksman/releases/latest | jq -r .tag_name)"
if [ "$(marksman --version 2>/dev/null)" = "$latest" ]; then
  log "marksman $latest already installed"
else
  log "Installing marksman $latest (Markdown) into ~/.local/bin"
  mkdir -p "$HOME/.local/bin"
  curl -fsSL -o "$HOME/.local/bin/marksman" \
    "https://github.com/artempyanykh/marksman/releases/download/$latest/marksman-macos"
  chmod +x "$HOME/.local/bin/marksman"
  xattr -c "$HOME/.local/bin/marksman" 2>/dev/null || true   # drop quarantine so Gatekeeper doesn't block it
fi
