local platform = require('utils.platform')

local options = {
  default_prog = { "pwsh" },
  launch_menu = {
    { label = "PowerShell", args = { "pwsh" } }
  },
  set_environment_variables = {
    prompt = '$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ',
  },
  front_end = "OpenGL",
}

if platform.is_win then
  options.default_prog = { 'arch.exe' }
  options.launch_menu = {
    { label = "Arch WSL", args = { "arch.exe" } },
    {
      label = "PowerShell",
      args = { "pwsh.exe" },
      domain = { DomainName = "local" },
      cwd = "C:\\Users\\Pranshu\\Desktop",
    },
    {
      label = "Command Prompt",
      args = { "cmd.exe" },
      domain = { DomainName = "local" },
      cwd = "C:\\Users\\Pranshu\\Desktop",
    },
  }
elseif platform.is_mac then
   options.default_prog = { 'fish' }
elseif platform.is_linux then
   options.default_prog = { 'fish' }
end

return options
