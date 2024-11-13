local platform = require('utils.platform')

local options = {
   default_prog = { "pwsh" },
}

if platform.is_win then
   options.default_prog = { 'arch.exe' }
elseif platform.is_mac then
   options.default_prog = { 'fish' }
elseif platform.is_linux then
   options.default_prog = { 'fish' }
end

return options
