-- local theme = require('colors/kanagawa')

return {
  -- colors
  -- colors = theme,
  color_scheme = 'Grayscale (dark) (terminal.sexy)',
  -- color_scheme = "Catppuccin Mocha",

  -- window paddings set to 0 for neovim
  window_padding = {
    left = '0cell',
    right = '0cell',
    top = '0cell',
    bottom = '0cell',
  },

  -- remove title bar
  window_decorations = "RESIZE",

  -- tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,

  -- FPS
  max_fps = 120,

  adjust_window_size_when_changing_font_size = false,
}
