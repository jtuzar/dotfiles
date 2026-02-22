# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
alias ls='ls -lah --color=auto'
alias task='go-task'
alias ffapil="cd ~/git/Firefish/packages/api/;mise exec -- yarn start --stage=dev-jakub-main;"
alias ffappl="cd ~/git/Firefish/packages/app/;mise exec -- yarn start;"
alias ffadminl="cd ~/git/Firefish/packages/admin/;mise exec -- yarn start;"
alias dn="~/notebook/scripts/create-daily-note.sh"
alias qn="~/notebook/scripts/create-quick-note.sh"

# Show fastfetch on shell startup (TTY only)
if [[ -t 1 ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/git/Odin:$PATH"
export PATH="$HOME/git/ols:$PATH"
