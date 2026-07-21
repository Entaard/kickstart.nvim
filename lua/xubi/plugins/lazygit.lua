-- Lazygit in a persistent, toggleable floating terminal (via toggleterm).
--
-- Why not kdheepak/lazygit.nvim? That plugin kills the lazygit process every
-- time you leave it, so reopening always lands at the top of the Files panel.
-- toggleterm HIDES the terminal instead of killing it, keeping the lazygit
-- process alive -- so toggling back returns to the exact same hunk.
--
-- Keys:
--   <leader>lg  (normal mode)   -> toggle lazygit (open, or re-show at the
--                                  same hunk if it was hidden)
--   <C-q>       (inside lazygit) -> HIDE lazygit, process keeps running
--   e           (inside lazygit) -> open the file at the current hunk line in
--                                   this nvim AND hide lazygit (keeps running),
--                                   so <leader>lg pops back to the same hunk.
--                                   (see scripts/lazygit-edit.sh + LazygitEdit)
--   q           (inside lazygit) -> QUIT/kill lazygit as usual
local lazygit = nil

-- Called from scripts/lazygit-edit.sh (via `nvim --server ... --remote-expr`)
-- when `e` is pressed inside lazygit. Hides lazygit (keeps it running) and
-- opens `file` at `line` in the previously-focused window.
function _G.LazygitEdit(file, line)
  vim.schedule(function()
    if lazygit then
      pcall(function()
        lazygit:close() -- hide window, keep the process alive
      end)
    end
    vim.cmd('edit ' .. vim.fn.fnameescape(file))
    pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(line) or 1, 0 })
    vim.cmd 'normal! zz'
  end)
  return ''
end

local function toggle_lazygit()
  if not lazygit then
    local Terminal = require('toggleterm.terminal').Terminal
    -- Use the config versioned in this repo (lazygit/config.yml) so the setup
    -- is portable across machines -- cloning to ~/.config/nvim is enough.
    local config = vim.fs.joinpath(vim.fn.stdpath 'config', 'lazygit', 'config.yml')
    lazygit = Terminal:new {
      cmd = 'lazygit --use-config-file ' .. vim.fn.shellescape(config),
      hidden = true,
      direction = 'float',
      float_opts = { border = 'rounded' },
      on_open = function(term)
        -- Send keystrokes straight to lazygit.
        vim.cmd 'startinsert!'
        -- <C-q>: hide (keep running). lazygit doesn't bind <C-q>, and leader
        -- (<space>) is intentionally left free for staging inside lazygit.
        vim.keymap.set('t', '<C-q>', function()
          term:toggle()
        end, { buffer = term.bufnr, desc = 'Hide lazygit (keep running)' })
      end,
    }
  end
  lazygit:toggle()
end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>lg', toggle_lazygit, desc = 'Toggle lazygit' },
  },
  opts = {},
}
