-- colorscheme
vim.cmd("colorscheme tokyonight")

-- tabs and spaces
vim.cmd("set expandtab")
vim.cmd("set smarttab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- line numbers
vim.cmd("set number")
vim.cmd("set relativenumber")

-- yank
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>Y', '"+yg_', { noremap = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>yy', '"+yy', { noremap = true })

-- paste
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true })
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('v', '<leader>P', '"+P', { noremap = true })

-- move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

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
vim.keymap.set('n', '<leader>dn', ':lua vim.diagnostic.open_float()<CR>', { noremap = true })

-- toggle markdown
vim.keymap.set('n', '<leader>md', ':RenderMarkdown toggle<CR>', { noremap = true })

-- toggle LSP virtual text
local virtual_text_enabled = true

local function toggle_virtual_text()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({ virtual_text = virtual_text_enabled })
end

vim.keymap.set('n', '<leader>lsp', toggle_virtual_text, { noremap = true })

-- fold settings
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=99")
