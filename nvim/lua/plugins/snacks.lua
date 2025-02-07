return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true, indent = { char = '┊' }},
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Lazygit
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- Notiifcations
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    -- References
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.dim():map("<leader>dim")
      end,
    })
  end,}
