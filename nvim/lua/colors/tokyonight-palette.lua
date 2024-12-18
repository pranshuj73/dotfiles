local function setColors(c)
  c._name = "tokyonight_night"
  c._style = "night"
  c.bg = "#000000"
  c.bg_dark = "#000000"
  c.bg_float = "#000000"
  c.bg_highlight = "#2c3b4d"
  c.bg_popup = "#000000"
  c.bg_search = "#2c4477"
  c.bg_sidebar = "#000000"
  c.bg_statusline = "#000000"
  c.bg_visual = "#2a3345"
  c.black = "#000000"
  c.blue = "#4a7ebf"
  c.blue0 = "#3b6d99"
  c.blue1 = "#3a7f98"
  c.blue2 = "#3b8f8f"
  c.blue5 = "#4a6f8e"
  c.blue6 = "#6a8ea3"
  c.blue7 = "#4b5e73"
  c.border = "#1b2a3c"
  c.border_highlight = "#1b7a8d"
  c.comment = "#3e4f6f"
  c.cyan = "#4a8c91"
  c.dark3 = "#3e475f"
  c.dark5 = "#4e5b7d"
  c.diff = {
    add = "#1f2f37",
    change = "#1e2232",
    delete = "#2a1c2b",
    text = "#2e3b53"
  }
  c.error = "#7a2c4d"
  c.fg = "#a3a9d9"
  c.fg_dark = "#7f8bb4"
  c.fg_float = "#a3a9d9"
  c.fg_gutter = "#2d3b4f"
  c.fg_sidebar = "#7f8bb4"
  c.git = {
    add = "#30798c",
    change = "#5a6f89",
    delete = "#9e4268",
    ignore = "#3e475f"
  }
  c.green = "#4a7d6f"
  c.green1 = "#4a7d6f"
  c.green2 = "#4a7d6f"
  c.hint = "#248b8b"
  c.info = "#3a8f8f"
  c.magenta = "#7b5fb3"
  c.magenta2 = "#9d2f56"
  c.none = "NONE"
  c.orange = "#b56e42"
  c.purple = "#6a4c87"
  c.rainbow = { "#4a7ebf", "#9e4268", "#4a7d6f", "#248b8b", "#7b5fb3", "#6a4c87" }
  c.red = "#9e4268"
  c.red1 = "#9e4268"
  c.teal = "#248b8b"
  c.terminal = {
    black = "#000000",
    black_bright = "#303c4b",
    blue = "#4a7ebf",
    blue_bright = "#6b8fc0",
    cyan = "#4a8c91",
    cyan_bright = "#7cb1c2",
    green = "#4a7d6f",
    green_bright = "#6f9c7f",
    magenta = "#7b5fb3",
    magenta_bright = "#9c72db",
    red = "#9e4268",
    red_bright = "#d1687e",
    white = "#7f8bb4",
    white_bright = "#a3a9d9",
    yellow = "#b56e42",
    yellow_bright = "#c78e5a"
  }
  c.terminal_black = "#303c4b"
  c.todo = "#4a7ebf"
  c.warning = "#9e4268"
  c.yellow = "#b56e42"
end

return setColors
