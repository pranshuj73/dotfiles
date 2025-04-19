return {
  "voltycodes/areyoulockedin.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    require("areyoulockedin").setup({
      session_key = "039ab6df-0ed2-431c-ab6c-voltyellow98",
    })
  end,
}
