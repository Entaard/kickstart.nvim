-- NOTE: for troubleshooting, run `:OmniSharpOpenLog` to open the log file.
vim.g.OmniSharp_loglevel = 'none' -- 'debug', 'info', 'none'
--
-- Run `:OmniSharpInstall v1.35.2` to install the server at a specific version, or just `:OmniSharpInstall` to install the latest version.
-- NOTE: If manually installing the server, you must set the path to the server executable.
-- vim.g.OmniSharp_server_path = '/Users/tuananhnguyen/.cache/omnisharp-vim/omnisharp-roslyn/OmniSharp'

vim.g.OmniSharp_server_use_mono = 0
vim.g.OmniSharp_server_use_net6 = 1

-- NOTE: for wsl:
-- vim.g.OmniSharp_translate_cygwin_wsl = 1

vim.g.OmniSharp_selector_ui = 'fzf'
vim.g.OmniSharp_selector_findusages = 'fzf'

-- async lint engine
vim.g.ale_lnters = { cs = 'OmnSharp' }

-- Semantic Highlighting
-- NOTE: Currently treesitter is doing this job too good, so this is disabled to avoid ugly colors.
vim.g.OmniSharp_highlighting = 0 -- Highlight after text change, even in insert mode. Default value is 1, which only highlights after leaving insert mode.
-- To find out the classification name of the symbol or character under the cursor, use the :OmniSharpHighlightEcho command
vim.g.OmniSharp_highlight_groups = {
  Comment = 'NonText',
  XmlDocCommentName = 'Identifier',
  XmlDocCommentText = 'NonText',
}

-- Diagnostic
-- OmniSharp-vim provides a global override dictionary, where any diagnostic can be marked as having severity Error, Warning or Info,
-- and for ALE/Syntastic users, a 'subtype': 'Style' may be specified. Diagnostics may be ignored completely by setting their 'type' to 'None',
-- in which case they will not be passed to linters, and will not be displayed in :OmniSharpGlobalCodeCheck results.
-- Example:
-- " IDE0010: Populate switch - display in ALE as `Info`
-- " IDE0055: Fix formatting - display in ALE as `Warning` style error
-- " RemoveUnnecessaryImportsFixable: Generic warning that an unused using exists
vim.g.OmniSharp_diagnostic_showid = 1
vim.g.OmniSharp_diagnostic_overrides = {
  IDE0010 = { type = 'I' },
  IDE0055 = { type = 'W', subtype = 'Style' },
  RemoveUnnecessaryImportsFixable = { type = 'I' },
}
vim.g.OmniSharp_diagnostic_exclude_paths = {
  'obj\\',
  'bin\\',
  '[Tt]emp\\',
  '.nuget\\',
  '<AssemblyInfo.cs>',
}

-- Popup
vim.g.OmniSharp_popup = 1
vim.g.OmniSharp_popup_position = 'center' -- 'atcursor', 'center', 'peek'
vim.g.OmniSharp_popup_options = {
  winblend = 0,
  winhl = 'Normal:Normal,FloatBorder:Special',
  border = 'rounded',
}

-- auto complete
vim.g.asyncomplete_auto_popup = 1
vim.g.asyncomplete_auto_completeopt = 0
-- vim.o.completeopt = 'menuone,noinsert,noselect,preview'
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.cmd 'autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif' -- auto close preview pane when completion is done

return {
  'OmniSharp/omnisharp-vim',
  dependencies = {
    -- 'nickspoons/vim-sharpenup',
    'dense-analysis/ale',
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'prabirshrestha/asyncomplete.vim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('omnisharp-vim', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { desc = 'OmniSharp: ' .. desc })
        end

        map('<leader>ro', ':OmniSharpRestartServer<CR>', '[R]estart [O]mniSharp')

        map('gd', ':OmniSharpGotoDefinition<CR>', '[G]oto [D]efinition')
        map('gr', ':OmniSharpFindUsages<CR>', '[G]oto [R]eferences')
        map('gI', ':OmniSharpFindImplementations<CR>', '[G]oto [I]mplementations')

        map('<leader>ld', ':OmniSharpDocumentation<CR>', '[L]ookup [D]ocument')
        map('<leader>lt', ':OmniSharpTypeLookup<CR>', '[L]ookup [T]ype')
        map('<leader>ls', ':OmniSharpSignatureHelp<CR>', '[L]ookup [S]ignature Help')
        map('<C-\\>', '<cmd>OmniSharpSignatureHelp<CR>', '[S]ignature Help', 'i')

        map('<leader>pd', ':OmniSharpPreviewDefinition<CR>', '[P]eek [D]efinition')
        map('<leader>pi', ':OmniSharpPreviewImplementation<CR>', '[P]eek [I]mplementation')

        map('<leader>ds', ':OmniSharpFindMembers<CR>', '[D]ocument [S]ymbols')
        map('<leader>ws', ':OmniSharpFindSymbol<CR>', '[W]orkspace [S]ymbols')

        map('<leader>rn', ':OmniSharpRename<CR>', '[R]e[n]ame', { 'n', 'x' })
        map('<leader>ca', ':OmniSharpGetCodeActions<CR>', '[C]ode [A]ction', { 'n', 'x' })
        map('<leader>fu', ':OmniSharpFixUsings<CR>', '[F]ix [U]sings')
      end,
    })
  end,
}
