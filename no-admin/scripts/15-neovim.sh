#!/usr/bin/env bash
# Install Neovim from the official prebuilt release into ~/.local (brew would build it
# from source under a non-default prefix, which needs the admin-only Command Line Tools).
set -euo pipefail; source "$(dirname "$0")/lib.sh"
arch="$(uname -m)"; [ "$arch" = "x86_64" ] || arch="arm64"
latest="$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)"
if command -v nvim >/dev/null && nvim --version | head -1 | grep -q "${latest#v}"; then
  log "Neovim $latest already installed"; exit 0
fi
log "Installing Neovim $latest ($arch) into ~/.local"
tmp="$(mktemp -d)"
curl -fsSL "https://github.com/neovim/neovim/releases/download/$latest/nvim-macos-$arch.tar.gz" | tar xz -C "$tmp"
xattr -cr "$tmp" 2>/dev/null || true   # drop quarantine so Gatekeeper doesn't block it
rm -rf "$HOME/.local/nvim"; mkdir -p "$HOME/.local/bin"
mv "$tmp/nvim-macos-$arch" "$HOME/.local/nvim"
ln -sf "$HOME/.local/nvim/bin/nvim" "$HOME/.local/bin/nvim"
rm -rf "$tmp"
nvim --version | head -1
