#/bin/zsh

sed -i '' 's/^background_tint 0.8/background_tint 0.96/' kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Frappe
kill -USR1 $KITTY_PID
