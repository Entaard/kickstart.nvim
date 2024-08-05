return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
  },
  config = function()
    require('hop').setup {}
    vim.keymap.set('n', '<leader>jw', ':HopWord<cr>', { desc = '[J]ump to [W]ord' })
    vim.keymap.set('n', '<leader>jl', ':HopLine<cr>', { desc = '[J]ump to [L]ine' })
    vim.keymap.set('n', '<leader>jc', ':HopChar2<cr>', { desc = '[J]ump to [C]har' })
    vim.keymap.set('n', '<leader>jn', ':HopNodes<cr>', { desc = '[J]ump to [N]odes' })
  end,
}
