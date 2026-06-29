return {
  'zapling/mason-lock.nvim',
  lazy = false,
  dependencies = {
    'williamboman/mason.nvim',
  },
  opts = {
    -- The path to the lockfile. Defaults to stdpath("config") .. "/mason-lock.json"
    lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json',
  },
}
