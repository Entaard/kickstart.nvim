vim.g.OmniSharp_server_path = '/Users/tuananhnguyen/.cache/omnisharp-vim/omnisharp-roslyn/OmniSharp'

vim.g.OmniSharp_server_use_net6 = 1

vim.g.OmniSharp_selector_ui = 'fzf'
vim.g.OmniSharp_selector_findusages = 'fzf'

vim.g.OmniSharp_popup = 1

-- async lint engine
vim.g.ale_lnters = { cs = 'OmnSharp' }

-- auto complete
vim.g.asyncomplete_auto_popup = 1
vim.g.asyncomplete_auto_completeopt = 0
vim.o.completeopt = 'menuone,noinsert,noselect,preview'

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'OmniSharp: ' .. desc })
end

map('<leader>ro', ':OmniSharpRestartServer<CR>', '[R]estart [O]mniSharp')

map('gd', ':OmniSharpGotoDefinition<CR>', '[G]oto [D]efinition')
map('gr', ':OmniSharpFindUsages<CR>', '[G]oto [R]eferences')
map('gI', ':OmniSharpFindImplementations<CR>', '[G]oto [I]mplementations')

map('<leader>ld', ':OmniSharpDocumentation<CR>', '[L]ookup [D]ocument')
map('<leader>lt', ':OmniSharpTypeLookup<CR>', '[L]ookup [T]ype')
map('<leader>ls', ':OmniSharpSignatureHelp<CR>', '[L]ookup [S]ignature Help')
vim.keymap.set('i', '<C-/>', '<cmd>OmniSharpSignatureHelp<CR>', { desc = '[S]ignature Help' })

map('<leader>ds', ':OmniSharpFindMembers<CR>', '[D]ocument [S]ymbols')
map('<leader>ws', ':OmniSharpFindSymbol<CR>', '[W]orkspace [S]ymbols')

map('<leader>rn', ':OmniSharpRename<CR>', '[R]e[n]ame')
map('<leader>ca', ':OmniSharpGetCodeActions<CR>', '[C]ode [A]ction')
map('<leader>fu', ':OmniSharpFixUsings<CR>', '[F]ix [U]sings')

return {
  'OmniSharp/omnisharp-vim',
  dependencies = {
    'dense-analysis/ale',
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'prabirshrestha/asyncomplete.vim',
  },
}
