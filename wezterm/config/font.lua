local wezterm = require('wezterm')

local font_family = "FiraCode Nerd Font Mono"

return {
  font = wezterm.font({
    family = font_family,
    weight = "Medium",
  }),
  harfbuzz_features = {"zero" , "ss01", "cv05"},
  font_size = 10.5,
  line_height = 1.15,
  dpi = 256,
}
