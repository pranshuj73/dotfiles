local wezterm = require('wezterm')
local platform = require('utils.platform')
local act = wezterm.action

local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'CTRL'
   mod.SUPER_REV = 'CTRL|ALT'
end


local keys = {
  -- panes --
  -- panes: split panes
  { key = [[\]], mods = mod.SUPER,     action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = [[\]], mods = mod.SUPER_REV, action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },

  -- panes: zoom+close pane
  { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
  { key = 'W',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = true }) },
  { key = 'w',     mods = mod.SUPER_REV, action = act.CloseCurrentPane({ confirm = false }) },

  -- pane: activate pane
  { key = 'LeftArrow',  mods = mod.SUPER_REV, action = act.ActivatePaneDirection 'Left'  },
  { key = 'RightArrow', mods = mod.SUPER_REV, action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = mod.SUPER_REV, action = act.ActivatePaneDirection 'Up'    },
  { key = 'DownArrow',  mods = mod.SUPER_REV, action = act.ActivatePaneDirection 'Down'  },

  -- pane: resize pane
  { key = 'LeftArrow',  mods = mod.SUPER_REV .. "|SHIFT", action = act.AdjustPaneSize { 'Left',  5 } },
  { key = 'RightArrow', mods = mod.SUPER_REV .. "|SHIFT", action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = mod.SUPER_REV .. "|SHIFT", action = act.AdjustPaneSize { 'Up',    5 } },
  { key = 'DownArrow',  mods = mod.SUPER_REV .. "|SHIFT", action = act.AdjustPaneSize { 'Down',  5 } },
}


return {
  leader = { key = 'Space', mods = mod.SUPER_REV, timeout_milliseconds = 1000 },
  keys = keys,
}