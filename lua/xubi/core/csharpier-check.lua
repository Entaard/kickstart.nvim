-- Highlight where a C# file deviates from CSharpier's formatting.
--
-- CSharpier is a formatter, not a linter -- it has no concept of per-line
-- "errors". So we run `csharpier format` on the buffer, diff the result
-- against the current contents, and surface the differing lines as
-- diagnostics. Runs when a C# file is opened (FileType cs) and after saving.
--
-- Commands:
--   :CsharpierCheck        re-run the check on the current buffer
--   :CsharpierCheckToggle  turn the highlighting on/off (global)
-- Toggle per buffer with `vim.b.csharpier_check_disable = true`.

local ns = vim.api.nvim_create_namespace 'csharpier_check'
local augroup = vim.api.nvim_create_augroup('csharpier-check', { clear = true })

-- Severity of the "not formatted" marks. Drop to INFO/HINT for something
-- subtler than a warning.
local SEVERITY = vim.diagnostic.severity.WARN

local function run(bufnr)
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr

  if vim.g.csharpier_check_disable or vim.b[bufnr].csharpier_check_disable then
    return
  end
  if vim.fn.executable 'csharpier' == 0 then
    return
  end
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= 'cs' then
    return
  end

  local path = vim.api.nvim_buf_get_name(bufnr)
  local sent = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local input = table.concat(sent, '\n')
  if #sent > 0 then
    input = input .. '\n' -- csharpier expects a trailing newline like a file
  end

  -- --no-cache: csharpier's format cache can report a file as already
  -- formatted and echo the input back unchanged, causing false negatives.
  local cmd = { 'csharpier', 'format', '--write-stdout', '--no-cache' }
  if path ~= '' then
    vim.list_extend(cmd, { '--stdin-path', path })
  end

  -- Run from the file's directory so csharpier resolves the repo's
  -- .editorconfig / .csharpierrc regardless of nvim's working directory.
  local cwd = path ~= '' and vim.fs.dirname(path) or nil

  vim.system(cmd, { stdin = input, text = true, cwd = cwd }, function(res)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      -- Failed (syntax error, ignored file, ...) or empty output: clear marks.
      if res.code ~= 0 or not res.stdout or res.stdout == '' then
        vim.diagnostic.reset(ns, bufnr)
        return
      end

      -- Buffer changed since we launched csharpier: our line numbers would be
      -- stale, so skip -- a later run (save/reopen) will catch up.
      local cur = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      if not vim.deep_equal(cur, sent) then
        return
      end

      local formatted = vim.split(res.stdout, '\n', { plain = true })
      if formatted[#formatted] == '' then
        table.remove(formatted) -- drop element from trailing newline
      end

      local a = table.concat(sent, '\n')
      local b = table.concat(formatted, '\n')
      if a == b then
        vim.diagnostic.reset(ns, bufnr) -- already formatted
        return
      end

      local diagnostics = {}
      -- indices hunks: { start_a, count_a, start_b, count_b } (1-indexed)
      for _, h in ipairs(vim.diff(a, b, { result_type = 'indices' })) do
        local start_a, count_a = h[1], h[2]
        if count_a == 0 then
          -- Pure insertion after line start_a: flag that boundary line.
          local lnum = math.max(start_a - 1, 0)
          table.insert(diagnostics, {
            lnum = lnum,
            col = 0,
            severity = SEVERITY,
            source = 'csharpier',
            message = 'CSharpier would add formatting here',
          })
        else
          for l = start_a, start_a + count_a - 1 do
            table.insert(diagnostics, {
              lnum = l - 1,
              col = 0,
              severity = SEVERITY,
              source = 'csharpier',
              message = 'Not CSharpier-formatted',
            })
          end
        end
      end
      vim.diagnostic.set(ns, bufnr, diagnostics)
    end)
  end)
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'cs',
  desc = 'Check CSharpier formatting on open',
  callback = function(args)
    run(args.buf)
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.cs',
  desc = 'Re-check CSharpier formatting after save',
  callback = function(args)
    run(args.buf)
  end,
})

vim.api.nvim_create_user_command('CsharpierCheck', function()
  run(0)
end, { desc = 'Check current buffer against CSharpier formatting' })

vim.api.nvim_create_user_command('CsharpierCheckToggle', function()
  vim.g.csharpier_check_disable = not vim.g.csharpier_check_disable
  if vim.g.csharpier_check_disable then
    vim.diagnostic.reset(ns)
    vim.notify 'CSharpier check: OFF'
  else
    vim.notify 'CSharpier check: ON'
    run(0)
  end
end, { desc = 'Toggle CSharpier formatting highlights' })
