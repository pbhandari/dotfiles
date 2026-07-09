-- Native LSP, replacing ALE's linting/navigation and vim-go/vim-scala.
--
-- Uses the Neovim 0.11+/0.12 native LSP API: nvim-lspconfig ships the base
-- server configs under lsp/, mason installs the server binaries, and
-- mason-lspconfig enables the installed servers via vim.lsp.enable.
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
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = { border = 'rounded', source = true },
            })

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
                    'pyright', -- python types/navigation
                    'ruff', -- python lint + format
                    'rust_analyzer', -- rust
                    'gopls', -- go (replaces vim-go)
                    'lua_ls', -- this config
                },
                automatic_enable = true,
            })
        end,
    },
}
