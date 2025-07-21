# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jakub/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


path+=('/home/jakub/.bin')

alias vim="nvim"
alias ls="ls -lah --color=auto"
alias lzd="lazydocker"
alias blt="bluetui"
alias spt="spotify_player"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export NODE_OPTIONS="--max-old-space-size=8192"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

eval "$(zoxide init --cmd cd zsh)"

eval "$(starship init zsh)"

if [[ -o interactive ]]; then
    fastfetch
fi
