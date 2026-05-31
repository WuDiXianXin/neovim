return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'UIEnter',
        config = function()
            require('lualine').setup({
                options = {
                    globalstatus = false, -- 设为 true 则全窗口共用一个 statusline
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },

                -- ==================== Section ====================
                sections = {
                    -- lualine_a = { 'mode' },
                    lualine_b = {
                        { 'branch', icon = '' },
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
                    },
                    lualine_c = {
                        'lsp_status',
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                        },
                    },
                    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
                    -- lualine_y = { 'progress' },
                    -- lualine_z = { 'location' }
                },

                inactive_sections = {},

                -- -- ==================== Winbar ====================
                -- winbar = {
                --     lualine_c = {
                --         {
                --             'filename',
                --             file_status = true, -- [关键设置] 启用文件状态显示
                --             path = 1, -- 可选: 0 = 仅文件名, 1 = 相对路径, 2 = 绝对路径
                --             symbols = { modified = '●', readonly = '', unnamed = 'No Name' },
                --         },
                --     },
                -- },
                --
                -- inactive_winbar = {
                --     lualine_c = {
                --         {
                --             'filename',
                --             file_status = true,
                --             path = 0,
                --             symbols = { modified = '●', readonly = '', unnamed = 'No Name' },
                --         },
                --     },
                -- },

                -- -- ==================== Tabline ====================
                tabline = {
                    lualine_a = { 'tabs' },
                    lualine_c = { 'buffers' },
                },

                extensions = { 'quickfix', 'toggleterm', 'fugitive' },
            })
        end,
    },
}
