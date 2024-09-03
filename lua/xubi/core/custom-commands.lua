-- Get full path of the current file
vim.api.nvim_create_user_command('GetFullPath', function()
  vim.api.nvim_command 'echo expand("%:p")'
end, { nargs = 0 })

-- Copy full path of the current file to clipboard
vim.api.nvim_create_user_command('CopyFullPath', function()
  vim.api.nvim_command 'let @+=expand("%:p")'
end, { nargs = 0 })
