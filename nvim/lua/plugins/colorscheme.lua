return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      on_colors = require("colors.tokyomidnight"),
      transparent = true,
    },
  },
  -- {
  --   "ramojus/mellifluous.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     colorset = "kanagawa_dragon",
  --   },
  --   config = function(_, opts)
  --     require("mellifluous").setup(opts)
  --     vim.cmd.colorscheme("mellifluous")
  --     vim.api.nvim_create_autocmd("ColorScheme", {
  --       pattern = "mellifluous",
  --       callback = function()
  --         vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
  --         vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = false })
  --         vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = false })
  --         vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false })
  --         vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { underline = false })
  --         vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { underline = false })
  --
  --         vim.api.nvim_set_hl(0, "@markup.underline", { underline = false })
  --         vim.api.nvim_set_hl(0, "@markup.link", { underline = false })
  --         vim.api.nvim_set_hl(0, "NeotestTarget", { underline = false })
  --       end,
  --     })
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
}
