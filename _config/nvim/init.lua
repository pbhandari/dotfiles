vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.cmd('source ~/.vimrc')

-- Neovim-specific configuration
-- (vim and nvim have incompatible undo formats, so use a separate undodir)
vim.opt.undodir = vim.fn.expand('~/.vim/backups.nvim')

-- fzf-lua -- Ctrl-Space to launch
vim.keymap.set('n', '<C-Space>', '<Cmd>FzfLua<CR>', { silent = true })
-- Many terminals send <C-@>/<Nul> for Ctrl-Space
vim.keymap.set('n', '<C-@>', '<Cmd>FzfLua<CR>', { silent = true })
