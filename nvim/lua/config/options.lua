-- tabs and spaces
vim.cmd("set expandtab")
vim.cmd("set smarttab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- line numbers
vim.cmd("set number")
vim.cmd("set relativenumber")

-- autoformatting
vim.g.autoformat = false

-- floating diagnostic
vim.diagnostic.config({
  float = {
    -- focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- fold settings
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=99")
