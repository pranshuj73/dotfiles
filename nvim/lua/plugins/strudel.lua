return {
  "gruvw/strudel.nvim",
  event = "BufRead *.str",
  build = "npm install",
  config = function()
    require("strudel").setup()

    -- autocommands for *.str files
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = "*.str",
      callback = function(args)
        local opts = { buffer = args.buf, noremap = true, silent = true }
        vim.keymap.set("n", "<C-CR>", function() require("strudel").update() end, opts)
        vim.keymap.set("n", "<C-.>", function() require("strudel").stop() end, opts)
      end,
    })

    -- update on save/write
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.str",
      callback = function()
        vim.cmd("StrudelUpdate")
      end,
    })
  end,
}

