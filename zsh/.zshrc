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
path+=('/home/jakub/.cargo/bin')
path+=('/home/jakub/.local/share/omarchy/bin')

alias vim="nvim"
alias ls="ls -lah --color=auto"
alias lzd="lazydocker"
alias blt="bluetui"
alias spt="spotify_player"
alias ngs="ngrok http --url=learning-koala-pumped.ngrok-free.app"
alias task="go-task"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export OMARCHY_PATH=$HOME/.local/share/omarchy
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export IS_OFFLINE=true #firefish specific env var
export NODE_OPTIONS=--max-old-space-size=32768
export STARSHIP_CONFIG=~/.config/starship/starship.toml

if [[ -z "${CLAUDECODE}" ]]; then
  eval "$(zoxide init --cmd cd zsh)"
fi
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

if [[ -o interactive ]]; then
    fastfetch
fi

# pnpm
export PNPM_HOME="/home/jakub/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
