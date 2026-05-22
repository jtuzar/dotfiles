# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

have() { command -v "$1" >/dev/null 2>&1; }

# --- Shared base (must work on every machine) -------------------------------

# Omarchy default aliases and functions, if installed.
[[ -f ~/.local/share/omarchy/default/bash/rc ]] && . ~/.local/share/omarchy/default/bash/rc

alias ls='ls -lah --color=auto'

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

if [[ -t 1 ]] && have fastfetch; then
  fastfetch
fi

# --- Per-machine overrides (not tracked in git) -----------------------------

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local

if [[ -d ~/.bashrc.d ]]; then
  for _f in ~/.bashrc.d/*.sh; do
    [[ -r "$_f" ]] && . "$_f"
  done
  unset _f
fi
