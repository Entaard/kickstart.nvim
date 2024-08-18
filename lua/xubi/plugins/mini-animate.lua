return {
  'echasnovski/mini.animate',
  opts = {
    cursor = {
      enable = false,
    },
    scroll = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 100, unit = 'total' },
    },
    resize = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 50, unit = 'total' },
    },
    open = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 50, unit = 'total' },
    },
    close = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 50, unit = 'total' },
    },
  },
}
