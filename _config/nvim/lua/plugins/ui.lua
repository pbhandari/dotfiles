return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = {
            options = {
                theme = 'molokai',
                icons_enabled = true,
                section_separators = '',
                component_separators = '',
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },

                lualine_b = { 'searchcount' },
                lualine_c = {

                    {
                        'filename',
                        path = 1,
                        file_status = true,
                    },
                },
                lualine_x = {
                    {
                        'filetype',
                        colored = false,
                        icon_only = true
                    },
                },
                lualine_y = {
                    {
                        'diff',
                        colored = true,
                        fmt = function(str) return str ~= '' and '±' or '' end,
                    },
                    { 'location', }
                },
                lualine_z = {
                    { 'diagnostic' },
                    { 'encoding',  show_bomb = true },
                },
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            indent = { char = '│' },
            scope = { enabled = false },
        },
    },
}
