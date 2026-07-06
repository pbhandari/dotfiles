local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set the Color Scheme
config.color_scheme = 'Molokai'

-- Set the Font to Monaco
config.font = wezterm.font_with_fallback {
  'Monaco',
  'Symbols Nerd Font Mono',
  'Hiragino Sans',
}
config.font_size = 14.0 -- Adjust this size to your preference

config.hide_tab_bar_if_only_one_tab = true
config.default_prog = {"zsh", "-l"}

-- Return the configuration to WezTerm
return config
