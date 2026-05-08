# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
alias ls='ls -lah --color=auto'
alias task='go-task'
alias oc='opencode'
alias occ='opencode --continue'

# Show fastfetch on shell startup (TTY only)
if [[ -t 1 ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/git/Odin:$PATH"
export PATH="$HOME/git/ols:$PATH"
export PATH="/home/jakub/.docker/sbx/bin:$PATH"
source "/home/jakub/.rover/env"
. "/home/jakub/.deno/env"
source /home/jakub/.local/share/bash-completion/completions/deno.bash

. "$HOME/.local/share/../bin/env"

# pnpm
export PNPM_HOME="/home/jakub/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
