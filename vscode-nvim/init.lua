-- leader key setup for vscode-neovim plugin
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- colorscheme
vim.cmd.colorscheme = ""

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

-- fold settings
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=99")
