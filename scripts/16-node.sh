#!/usr/bin/env bash
# Install the current Node.js LTS from the official prebuilt release into ~/.local
# (brew's node would build from source under a non-default prefix; system Node is v16).
# Global npm packages go to ~/.local/bin via the npm prefix, so they survive Node upgrades.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
arch="$(uname -m)"; [ "$arch" = "x86_64" ] && arch="x64" || arch="arm64"
latest="$(curl -fsSL https://nodejs.org/dist/index.json | jq -r '[.[] | select(.lts != false)][0].version')"
if [ "$(command -v node)" = "$HOME/.local/bin/node" ] && [ "$(node --version)" = "$latest" ]; then
  log "Node $latest already installed"
else
  log "Installing Node $latest ($arch) into ~/.local"
  tmp="$(mktemp -d)"
  curl -fsSL "https://nodejs.org/dist/$latest/node-$latest-darwin-$arch.tar.gz" | tar xz -C "$tmp"
  xattr -cr "$tmp" 2>/dev/null || true   # drop quarantine so Gatekeeper doesn't block it
  rm -rf "$HOME/.local/node"; mkdir -p "$HOME/.local/bin"
  mv "$tmp/node-$latest-darwin-$arch" "$HOME/.local/node"
  for b in node npm npx; do ln -sf "$HOME/.local/node/bin/$b" "$HOME/.local/bin/$b"; done
  rm -rf "$tmp"
fi
npm config set prefix "$HOME/.local"
node --version
