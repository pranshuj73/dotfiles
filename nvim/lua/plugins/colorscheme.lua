return  {
  -- "rebelot/kanagawa.nvim",
  -- "slugbyte/lackluster.nvim",
  -- "catppuccin/nvim",
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_colors = require("../colors/tokyonight-palette"),
    })
    -- vim.opt.background = "dark"
    -- vim.cmd("colorscheme kanagawa-dragon")
    -- vim.cmd.colorscheme("lackluster-hack")
    vim.cmd("colorscheme tokyonight-night")
  end
}
