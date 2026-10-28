-- save by pressing Escape (only file buffers, only when changed)
vim.keymap.set('n', '<Esc>', function()
  if vim.bo.buftype == '' then vim.cmd('silent! update') end
end, { desc = 'Save' })
-- select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select All' })
-- pasting over a selection no longer clobbers your clipboard
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])

