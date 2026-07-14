-- VSCode-style breadcrumbs in the winbar + interactive picker.
-- Analog to VSCode's `breadcrumbs.focusAndSelect`: <leader>b opens a picker
-- on the symbol path under the cursor so you can inspect / jump to the
-- enclosing class, method, etc. Sources fall back LSP -> treesitter -> path.
return {
  'Bekaboo/dropbar.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('dropbar').setup()

    local api = require 'dropbar.api'
    vim.keymap.set('n', '<leader>b', api.pick, { desc = '[B]readcrumb pick (focus & select)' })
    vim.keymap.set('n', 'gm', api.goto_context_start, { desc = '[G]oto enclosing [M]ethod/symbol start' })
  end,
}
