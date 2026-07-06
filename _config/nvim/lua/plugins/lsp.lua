-- Native LSP, replacing ALE's linting/navigation and vim-go/vim-scala.
--
-- Uses the Neovim 0.11+/0.12 native LSP API: nvim-lspconfig ships the base
-- server configs under lsp/, mason installs the server binaries, and
-- mason-lspconfig enables the installed servers via vim.lsp.enable.
-- Keymaps (gd/gu/<leader>r/etc.) live in config/nvim.lua so they override the
-- old ALE mappings from ~/.vimrc.
return {
  -- Server binary manager.
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog', 'MasonUpdate' },
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Diagnostics UI.
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = 'rounded', source = true },
      })

      -- Per-server tweaks on top of lspconfig's defaults.
      -- pyright auto-detects the active virtualenv (.venv / $VIRTUAL_ENV);
      -- ruff handles linting + formatting (replacing ALE's python setup).
      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- lua_ls: teach it about the Neovim runtime so editing this config is sane.
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
          },
        },
      })

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'pyright',       -- python types/navigation
          'ruff',          -- python lint + format
          'rust_analyzer', -- rust
          'gopls',         -- go (replaces vim-go)
          'lua_ls',        -- this config
        },
        -- mason-lspconfig enables installed servers via vim.lsp.enable.
        automatic_enable = true,
      })
    end,
  },

  -- Scala: metals is best driven by nvim-metals rather than mason-lspconfig.
  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = { 'scala', 'sbt' },
    config = function()
      local metals = require('metals')
      local cfg = metals.bare_config()
      cfg.settings = { showImplicitArguments = true }
      cfg.init_options.statusBarProvider = 'off'

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'scala', 'sbt' },
        callback = function()
          metals.initialize_or_attach(cfg)
        end,
        group = vim.api.nvim_create_augroup('metals', { clear = true }),
      })
    end,
  },
}
