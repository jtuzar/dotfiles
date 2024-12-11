#/bin/zsh

sed -i '' 's/background_tint 0.96/background_tint 0.8/' ~/mygit/dotfiles/kitty/kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Latte
kill -USR1 $KITTY_PID

