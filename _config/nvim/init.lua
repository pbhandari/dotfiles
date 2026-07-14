-- ~/.config/nvim/init.lua
--
-- Leader must be set before lazy.nvim loads
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')

-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  -- Do NOT reset the runtimepath: we rely on ~/.vim being on it (above).
  performance = { rtp = { reset = false } },
  change_detection = { notify = false },
})

-- Shared settings, remaps, autocmds, and `colorscheme molokai` live here.
-- Sourced after lazy so plugins (molokai, etc.) are already on the rtp.
vim.cmd('source ~/.vimrc')

-- ---------------------------------------------------------------------------
-- nvim-specific overrides. Everything below runs AFTER ~/.vimrc so it wins
-- over the shared VimL settings (notably the old ALE keymaps).
-- ---------------------------------------------------------------------------

-- vim and nvim have incompatible undo formats, so use a separate undodir.
vim.opt.undodir = vim.fn.expand('~/.vim/backups.nvim')

local map = vim.keymap.set

-- <leader>f is the fzf-lua picker prefix; <leader>f<leader> opens the full picker.
map('n', '<leader>f<leader>', '<Cmd>FzfLua<CR>', { silent = true, desc = 'FzfLua' })
map('n', '<leader>ff', '<Cmd>FzfLua files<CR>', { silent = true, desc = 'FzfLua: files' })
map('n', '<leader>fb', '<Cmd>FzfLua buffers<CR>', { silent = true, desc = 'FzfLua: buffers' })
map('n', '<leader>fo', '<Cmd>FzfLua oldfiles<CR>', { silent = true, desc = 'FzfLua: oldfiles' })
map('n', '<leader>f/', '<Cmd>FzfLua live_grep resume=true<CR>', { silent = true, desc = 'FzfLua: live grep' })
map('n', '<leader>fd', '<Cmd>FzfLua lsp_live_workspace_symbols<CR>', { silent = true, desc = 'FzfLua: workspace symbols (functions/classes)' })

-- undotree .
map('n', '<leader><leader>u', '<Cmd>UndotreeToggle<CR>', { silent = true, desc = 'Undotree' })

-- LSP navigation
map('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: go to definition' })
map('n', 'gu', vim.lsp.buf.references, { desc = 'LSP: references' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: implementation' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: declaration' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: hover' })
map('n', '<leader>r', vim.lsp.buf.rename, { desc = 'LSP: rename' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: code action' })
map('n', '<localleader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'LSP: format' })
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, { desc = 'LSP: format buffer' })

-- Format on save (synchronous so it completes before the write).
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = true }),
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf, async = false })
  end,
})

-- Diagnostics navigation.
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Prev diagnostic' })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

-- Terminal mode: Esc leaves terminal mode (replaces the awkward <C-\><C-n>).
map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Terminal: to normal mode' })
-- Ctrl-V Esc sends a literal Esc through to the program
map('t', '<C-v><Esc>', '<Esc>', { desc = 'Terminal: send literal Esc' })
