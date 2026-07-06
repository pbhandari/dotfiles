-- Molokai colorscheme. `colorscheme molokai` is called from ~/.vimrc, so this
-- must load at startup (lazy = false) and early (high priority) so the scheme
-- exists on the rtp by the time ~/.vimrc is sourced.
return {
  {
    'tomasr/molokai',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.rehash256 = 1
    end,
  },
}
