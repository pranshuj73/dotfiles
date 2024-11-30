return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend", -- using "skip" causes spawning error
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "graphql",
          "tailwindcss",
          "jsonls",
          "html",
          "cssls",
          "eslint",
          "ast_grep",
        },
        automatic_installation = true
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local opts = {
        capabilites = capabilities
      }
      lspconfig.lua_ls.setup(opts)
      lspconfig.ts_ls.setup(opts)
      lspconfig.graphql.setup(opts)
      lspconfig.tailwindcss.setup(opts)
      lspconfig.jsonls.setup(opts)
      lspconfig.html.setup(opts)
      lspconfig.cssls.setup(opts)
      lspconfig.eslint.setup(opts)
      lspconfig.ast_grep.setup(opts)

      -- MAPPINGS
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
