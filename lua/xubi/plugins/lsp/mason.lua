return {
  'williamboman/mason-lspconfig.nvim',
  opts = {
    ensure_installed = {
      'cssls',
      'docker_compose_language_service',
      'dockerls',
      'gopls',
      'html',
      'lua_ls',
    },
  },
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        -- registries to install roslyn_ls
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
        ensure_installed = {
          'codespell',
          'csharpier',
          'prettier',
          'roslyn_ls',
          'stylua',
        },
      },
    },
    'neovim/nvim-lspconfig',
  },
}
