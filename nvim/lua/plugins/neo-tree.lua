return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- IMAGE SUPPORT
  },
  opts = {
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      }
    }
  },
  keys = {
    {"<C-n>", "<cmd>Neotree filesystem reveal right<CR>" },
  },
}
