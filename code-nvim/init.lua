if vim.g.vscode then
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  map('n', '<Space>', '', opts)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- yank to system clipboard
  map({ 'n', 'v' }, '<leader>y', '"+y', opts)

  -- paste from system clipboard
  map({ 'n', 'v' }, '<leader>p', '"+p', opts)

  -- better indent handling
  map('v', '<', '<gv', opts)
  map('v', '>', '>gv', opts)

  -- move text up and down
  map('v', 'J', ':m .+1<CR>==', opts)
  map('v', 'K', ':m .-2<CR>==', opts)
  map('x', 'J', ":move '>+1<CR>gv-gv", opts)
  map('x', 'K', ":move '<-2<CR>gv-gv", opts)

  -- paste preserves primal yanked piece
  map('v', 'p', '"_dP', opts)

  -- removes highlighting after escaping vim search
  map('n', '<Esc>', '<Esc>:noh<CR>', opts)

  local code = require 'vscode'
  map({ 'n', 'x' }, '<leader>sf', function()
    code.action 'workbench.action.quickOpen'
  end, opts)
  map({ 'n', 'x' }, '<leader>sg', function()
    code.action 'workbench.action.findInFiles'
  end, opts)
  map({ 'n', 'x' }, '<leader>ss', function()
    code.action 'workbench.action.quickTextSearch'
  end)
  map({ 'n', 'x' }, '<leader>ef', function()
    code.action 'workbench.view.explorer'
  end, opts)
  map({ 'n', 'x' }, '<leader>b', function()
    code.action 'workbench.action.toggleSidebarVisibility'
  end, opts)
  map({ 'n', 'x' }, '<leader>x', function()
    code.action 'workbench.action.closeActiveEditor'
  end, opts)
  map({ 'n', 'x' }, '<leader>o', function()
    code.action 'workbench.action.files.newUntitledFile'
  end, opts)
  map({ 'n' }, '<leader>p', function()
    code.action 'workbench.action.previousEditor'
  end, opts)
  map({ 'n' }, '<leader>n', function()
    code.action 'workbench.action.nextEditor'
  end, opts)
  map({ 'n', 'x' }, 'gI', function()
    code.action 'editor.action.goToImplementation'
  end)
  map({ 'n', 'x' }, 'gd', function()
    code.action 'editor.action.revealDefinition'
  end)
  map({ 'n', 'x' }, 'gr', function()
    code.action 'references-view.findReferences'
  end)
  map({ 'n', 'x' }, 'gR', function()
    code.action 'editor.action.goToReferences'
  end)
  map({ 'n', 'x' }, '<leader>gr', function()
    code.action 'references-view.tree.focus'
  end)
  map({ 'n', 'x' }, 'gD', function()
    code.action 'editor.action.peekDefinition'
  end)
  map({ 'n', 'x' }, 'gi', function()
    code.action 'editor.action.peekImplementation'
  end)
  map({ 'n', 'x' }, '<leader>ds', function()
    code.action 'workbench.action.gotoSymbol'
  end)
  map({ 'n', 'x' }, '<leader>ws', function()
    code.action 'workbench.action.showAllSymbols'
  end)
  map({ 'n', 'x' }, '<leader>sd', function()
    code.action 'editor.action.marker.next'
  end)
  map({ 'n', 'x' }, '<leader>sD', function()
    code.action 'editor.action.marker.prev'
  end)
  map({ 'n', 'x' }, '<leader>rn', function()
    code.action 'editor.action.rename'
  end)
  map({ 'n', 'x' }, '<leader>u', function()
    code.action 'workbench.action.files.save'
  end)
  map({ 'n', 'x' }, '<C-o>', function()
    code.action 'workbench.action.navigateBack'
  end)
  map({ 'n', 'x' }, '<C-i>', function()
    code.action 'workbench.action.navigateForward'
  end)
  map({ 'n', 'x' }, '<leader>/', function()
    code.action 'actions.find'
  end)
  map({ 'n', 'x' }, '<leader>z', function()
    code.action 'workbench.action.closeSidebar'
    code.action 'workbench.action.closePanel'
  end)
  map({ 'n', 'x' }, '<leader>ca', function()
    code.action 'editor.action.quickFix'
  end)
  map({ 'x' }, '<leader>f', function()
    code.action 'editor.action.formatSelection'
  end)
else
  -- ordinary Neovim
end
