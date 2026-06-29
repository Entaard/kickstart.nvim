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
  config = function(_, opts)
    require('mason-lspconfig').setup(opts)
    vim.lsp.enable('gdscript')
  end,
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
          'gdtoolkit',
        },
      },
      config = function(_, opts)
        require('mason').setup(opts)
        local registry = require 'mason-registry'
        local function install_ensured()
          for _, tool in ipairs(opts.ensure_installed or {}) do
            local ok, p = pcall(registry.get_package, tool)
            if ok and not p:is_installed() then
              p:install()
            end
          end
        end
        if registry.refresh then
          pcall(registry.refresh, install_ensured)
        else
          install_ensured()
        end
      end,
    },
    'neovim/nvim-lspconfig',
  },
}
