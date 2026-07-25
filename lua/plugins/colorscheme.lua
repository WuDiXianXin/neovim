-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- require('tokyonight').setup()
            require('tokyonight').setup({ transparent = true })

            -- moon, night, storm, day
            vim.cmd([[colorscheme tokyonight-moon]])

            local function transparent_theme()
                local groups = {
                    'CursorLine',
                    -- 'FloatTitle',
                    'FloatBorder',
                    'NormalFloat',
                    'Pmenu',
                    'BlinkCmpMenu',
                    'BlinkCmpMenuBorder',
                    'WhichKeyNormal',
                    'StatusLine',
                    'StatusLineNC',
                    'Tabline',
                    'TabLineFill',
                    'TabLineSel',
                    'Winbar',
                    'WinbarNC',
                }

                for _, group in ipairs(groups) do
                    vim.api.nvim_set_hl(0, group, { bg = 'none' })
                end

                vim.api.nvim_set_hl(0, 'MsgArea', { fg = '#c8b0d4', bg = 'none' })
                vim.api.nvim_set_hl(0, 'Comment', { fg = '#b0d4d4', bg = 'none' })
            end

            transparent_theme()
        end,
    },
}
