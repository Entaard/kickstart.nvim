return {
  'echasnovski/mini.animate',
  opts = {
    cursor = {
      enable = false,
    },
    scroll = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 25, unit = 'total' },
    },
    resize = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 25, unit = 'total' },
    },
    open = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 25, unit = 'total' },
    },
    close = {
      enable = true,
      timing = require('mini.animate').gen_timing.linear { duration = 25, unit = 'total' },
    },
  },
}