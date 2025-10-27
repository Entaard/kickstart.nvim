vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Disable global auto format
-- vim.g.disable_autoformat = 1

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)
vim.schedule(function()
  local ok = pcall(require, 'vim.ui.clipboard.osc52')
  if ok then
    local osc52 = require 'vim.ui.clipboard.osc52'
    vim.g.clipboard = {
      name = 'osc52',
      copy = {
        ['+'] = osc52.copy '+',
        ['*'] = osc52.copy '*',
      },
      paste = {
        ['+'] = osc52.paste '+',
        ['*'] = osc52.paste '*',
      },
    }
    -- If you want every yank to hit Windows clipboard by default:
    -- vim.opt.clipboard = 'unnamedplus'
  else
    -- Fallback: no osc52 in this Neovim -> do nothing here
    -- (see Section 4 for plugin fallback)
  end
end)

-- tabs & indentation
vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- Enable break indent
vim.opt.breakindent = true

vim.opt.wrap = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- backspace
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable autoread: automatically re-read a file if it has been changed on disk
-- and the buffer has not been modified in Neovim.
vim.opt.autoread = true
