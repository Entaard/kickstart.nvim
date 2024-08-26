return {
  'Vonr/align.nvim',
  branch = 'v2',
  lazy = true,
  init = function()
    local ns = { noremap = true, silent = true }
    vim.keymap.set('x', '<leader>aa', function ()
      require('align').align_to_char({
        length = 1
      })
    end, ns)

    vim.keymap.set('x', '<leader>ad', function ()
      require('align').align_to_char({
        length = 2,
        preview = true
      })
    end, ns)

    vim.keymap.set('x', '<leader>aw', function ()
      require('align').align_to_string({
        preview = true,
        regex = false
      })
    end, ns)

    vim.keymap.set('x', '<leader>ar', function ()
      require('align').align_to_string({
        preview = true,
        regex = true
      })
    end, ns)
  end
}
