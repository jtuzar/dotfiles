-- Wezterm config mirroring linux/ghostty/.config/ghostty/config
local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 13.0

-- Theme (ghostty pulls from omarchy on Linux; pick a sensible dark default here)
config.color_scheme = "Tokyo Night Storm"

-- Window
config.window_padding = { left = 14, right = 14, top = 14, bottom = 14 }
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Cursor (block, no blink)
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

-- Default shell: WSL (launches the default distribution)
config.default_prog = { "wsl.exe", "--cd", "~" }

-- Slow down mouse scrolling to match ghostty's 0.95 multiplier
local function scroll_lines(n)
  return wezterm.action_callback(function(window, pane)
    window:perform_action(act.ScrollByLine(n), pane)
  end)
end
config.mouse_bindings = {
  { event = { Down = { streak = 1, button = { WheelUp = 1 } } },   mods = "NONE", action = scroll_lines(-3) },
  { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = "NONE", action = scroll_lines(3) },
}

-- Leader for the ctrl+b > <key> split bindings
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
  -- shift+enter sends a literal newline
  { key = "Enter", mods = "SHIFT", action = act.SendString("\n") },

  -- Move between splits (ghostty: ctrl+shift+h/j/k/l)
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

  -- Create new splits (ghostty: ctrl+b > h/j/k/l)
  { key = "h", mods = "LEADER", action = act.SplitPane({ direction = "Left",  size = { Percent = 50 } }) },
  { key = "j", mods = "LEADER", action = act.SplitPane({ direction = "Down",  size = { Percent = 50 } }) },
  { key = "k", mods = "LEADER", action = act.SplitPane({ direction = "Up",    size = { Percent = 50 } }) },
  { key = "l", mods = "LEADER", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },

  -- Alt+1..9 jumps to tab N (like Windows Terminal / browsers)
  { key = "1", mods = "ALT", action = act.ActivateTab(0) },
  { key = "2", mods = "ALT", action = act.ActivateTab(1) },
  { key = "3", mods = "ALT", action = act.ActivateTab(2) },
  { key = "4", mods = "ALT", action = act.ActivateTab(3) },
  { key = "5", mods = "ALT", action = act.ActivateTab(4) },
  { key = "6", mods = "ALT", action = act.ActivateTab(5) },
  { key = "7", mods = "ALT", action = act.ActivateTab(6) },
  { key = "8", mods = "ALT", action = act.ActivateTab(7) },
  { key = "9", mods = "ALT", action = act.ActivateTab(8) },
}

return config
