vim.cmd("set expandtab")
vim.cmd("set smarttab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.g.mapleader = " "

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>Y', '"+yg_', { noremap = true })
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>yy', '"+yy', { noremap = true })

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true })
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true })
vim.keymap.set('v', '<leader>P', '"+P', { noremap = true })

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Floating Diagnostic
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

-- Toggle Markdown
vim.keymap.set('n', '<leader>md', ':RenderMarkdown toggle<CR>', { noremap = true })

-- Toggle LSP Virtual Text
local virtual_text_enabled = true

local function toggle_virtual_text()
    virtual_text_enabled = not virtual_text_enabled
    vim.diagnostic.config({ virtual_text = virtual_text_enabled })
end

vim.keymap.set('n', '<leader>lsp', toggle_virtual_text, { noremap = true })

-- Fold settings
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=99")

