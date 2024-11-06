local wezterm = require('wezterm')

local font_family = "FiraCode Nerd Font Mono"

return {
  font = wezterm.font({
    family = font_family,
    weight = "Regular",
  }),
  harfbuzz_features = {"zero" , "ss01", "cv05"},
  font_size = 9.5,
  line_height = 1.1,
}
