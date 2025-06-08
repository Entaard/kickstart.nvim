return {
  'tzachar/highlight-undo.nvim',
  opts = {
    hlgroup = 'highlightundo',
    duration = 300,
    pattern = { '*' },
    ignored_filetypes = { 'neo-tree', 'fugitive', 'telescopeprompt', 'mason', 'lazy' },
    -- ignore_cb is in comma as there is a default implementation. setting
    -- to nil will mean no default os called.
    -- ignore_cb = nil,
  },
}
