return {
    'boganworld/crackboard.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crackboard').setup({
        session_key = '9ea8c8d5c6e63d223dfa71a7f9c57b97f3b63777c946b3e7533631b97d0ee6f7',
      })
    end,
  }
