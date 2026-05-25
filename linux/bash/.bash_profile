#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
source "/home/jakub/.rover/env"
. "/home/jakub/.deno/env"
source /home/jakub/.local/share/bash-completion/completions/deno.bash

. "$HOME/.local/share/../bin/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
