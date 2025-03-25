local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_family = "FiraCode Nerd Font Mono"

if platform.is_win then
  return {
    font = wezterm.font({
      family = font_family,
      weight = "Regular",
    }),
    harfbuzz_features = {"zero" , "ss01", "cv05"},
    font_size = 9.5,
    line_height = 1.1,
  }
end

return {
  font = wezterm.font({
    family = font_family,
    weight = "Medium",
  }),
  harfbuzz_features = {"zero" , "ss01", "cv05"},
  font_size = 10.5,
  line_height = 1.15,
  warn_about_missing_glyphs=false,
}
