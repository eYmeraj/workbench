#!/usr/bin/env bash
# Per-user macOS defaults.
set -euo pipefail; source "$(dirname "$0")/lib.sh"
log "Applying macOS defaults"
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
killall Dock Finder SystemUIServer 2>/dev/null || true
echo "   key repeat and tap-to-click fully apply after logging out and back in"
