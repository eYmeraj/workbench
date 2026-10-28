#!/usr/bin/env bash
# Set up this Mac for coding with agents (admin access, standard Homebrew).
#   ./install.sh            run every step
#   ./install.sh 20 40      run only the steps whose number prefix matches
# Every step is idempotent, so it's safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"
for s in scripts/[0-9]*.sh; do
  n="$(basename "$s" | cut -d- -f1)"
  if [ $# -gt 0 ] && [[ ! " $* " == *" $n "* ]]; then continue; fi
  bash "$s"
done
printf '\n\033[32mDone.\033[0m Open WezTerm (/Applications/WezTerm.app), or run: exec zsh\n'
