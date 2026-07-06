-- Editing/navigation plugins. Keeps the tpope classics that still have no
-- better replacement, swaps vim-surround for nvim-surround, and keeps fzf-lua
-- and undotree. (vim-commentary is dropped: nvim 0.10+ ships gc/gcc natively.)
return {
  -- nvim-surround replaces tpope/vim-surround (Lua, dot-repeat aware).
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  -- fzf-lua: fuzzy finder (nvim-native successor to fzf.vim). Keymaps live in
  -- config/nvim.lua.
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    opts = {},
  },

  -- undotree: unchanged upstream, still the best undo visualizer.
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  },

  -- tpope classics with no better nvim replacement. Loaded lazily.
  { 'tpope/vim-fugitive', cmd = { 'G', 'Git', 'Gdiffsplit', 'Gblame', 'Gwrite', 'Gread' } },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-rsi', event = 'VeryLazy' },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
  { 'tpope/vim-eunuch', cmd = { 'Delete', 'Move', 'Rename', 'Chmod', 'Mkdir', 'SudoWrite', 'SudoEdit' } },
  { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } },
}
