#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: GNU stow is required but not installed." >&2
  exit 1
fi

cd "$DOTFILES_DIR"

stow_package_dir() {
  local package_root="$1"
  if [[ ! -d "$package_root" ]]; then
    return
  fi

  while IFS= read -r package; do
    echo "Stowing $package_root/$package"
    stow --restow --target="$HOME" --dir="$package_root" "$package"
  done < <(find "$package_root" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
}

# Ensure tool config dirs exist as real directories first, so stow links the
# individual AGENTS.md files into them instead of folding the whole directory
# into a single symlink pointing back into this repo.
mkdir -p "$HOME/.claude" "$HOME/.codex" "$HOME/.config/opencode"

stow_package_dir "shared"
stow_package_dir "linux"

# Per-machine bash overrides — sourced by ~/.bashrc, never committed.
touch "$HOME/.bashrc.local"

echo "Done."
