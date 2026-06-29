-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup()

    -- 1. Explicitly install the desired parsers
    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'c_sharp',
      'json',
      'yaml',
      'toml',
      'gdscript',
    }
    ts.install(parsers)

    -- 2. Enable features via Autocommands
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'query',
        'vim',
        'vimdoc',
        'cs', -- C# filetype in vim
        'json',
        'yaml',
        'toml',
        'gdscript',
      },
      callback = function(args)
        -- Enable native syntax highlighting
        pcall(vim.treesitter.start, args.buf)

        -- Enable treesitter-based indentation
        pcall(function()
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
      end,
    })

    -- 3. Configure native incremental selection keymaps (Neovim 0.12+)
    pcall(function()
      vim.keymap.set('n', '<C-space>', function()
        vim.cmd('normal! v')
        require('vim.treesitter._select').select_parent(1)
      end, { desc = 'Init treesitter selection' })

      vim.keymap.set('x', '<C-space>', function()
        require('vim.treesitter._select').select_parent(vim.v.count1)
      end, { desc = 'Expand treesitter selection' })

      vim.keymap.set('x', '<bs>', function()
        require('vim.treesitter._select').select_child(vim.v.count1)
      end, { desc = 'Shrink treesitter selection' })
    end)
  end,
}
