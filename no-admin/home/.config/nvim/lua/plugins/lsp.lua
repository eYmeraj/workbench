-- Language servers. The binaries come from ~/workbench/no-admin/scripts/17-language-servers.sh
-- (sourcekit-lsp ships with Xcode), nvim-lspconfig supplies each server's defaults,
-- and Neovim's built-in LSP client does the rest.
return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      vim.lsp.config('pyright', {  -- use the project's .venv, so its packages resolve
        before_init = function(_, config)
          local python = config.root_dir and config.root_dir .. '/.venv/bin/python'
          if python and vim.uv.fs_stat(python) then
            config.settings.python = vim.tbl_extend('force', config.settings.python or {}, { pythonPath = python })
          end
        end,
      })
      vim.lsp.enable({
        'vtsls', 'pyright', 'lua_ls', 'sourcekit',   -- TypeScript/JavaScript, Python, Lua, Swift
        'html', 'cssls', 'jsonls', 'tailwindcss',    -- web (tailwindcss idles outside Tailwind projects)
        'bashls', 'yamlls', 'marksman',              -- shell, YAML, Markdown
      })

      -- show errors and warnings at the end of the line (hints like unused variables are already dimmed)
      vim.diagnostic.config({ virtual_text = { severity = { min = vim.diagnostic.severity.WARN } } })

      -- completion menu as you type in code files (not in pickers or Oil),
      -- from the language server first, then words from open buffers.
      -- Markdown gets server items only (links, headings), so prose stays quiet.
      vim.o.completeopt = 'menuone,noselect,popup'
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)  -- <C-y> on an item also adds its import
          vim.bo[ev.buf].complete = vim.bo[ev.buf].filetype == 'markdown' and 'o' or 'o,.,w,b'
          vim.bo[ev.buf].autocomplete = true
        end,
      })
    end,
  },
}
