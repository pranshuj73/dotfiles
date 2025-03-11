local wezterm = require('wezterm')

-- set window size and center window on startup
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().main
  local ratio = 0.6
  local width, height = screen.width * ratio, screen.height * ratio
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {
    position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
  })
  -- window:gui_window():maximize()
  window:gui_window():set_inner_size(width, height)
end)

---@class Config
---@field options table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
   local config = setmetatable({ options = {} }, self)
   return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
   for k, v in pairs(new_options) do
      if self.options[k] ~= nil then
         wezterm.log_warn(
            'Duplicate config option detected: ',
            { old = self.options[k], new = new_options[k] }
         )
         goto continue
      end
      self.options[k] = v
      ::continue::
   end
   return self
end

return Config
