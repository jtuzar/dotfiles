# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
alias ls='ls -lah --color=auto'

# Show fastfetch on shell startup (TTY only)
if [[ -t 1 ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# Make an alias for invoking commands you use constantly
# alias p='python'
export PATH="$HOME/.local/bin:$PATH"
