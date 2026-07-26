-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({ transparent = vim.g.transparent })

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

                local fg_overrides = {
                    MsgArea = '#c8b0d4',
                    Comment = '#b0d4d4',
                }

                for _, group in ipairs(groups) do
                    vim.api.nvim_set_hl(0, group, { bg = 'none' })
                end

                for group, fg in pairs(fg_overrides) do
                    vim.api.nvim_set_hl(0, group, { fg = fg, bg = 'none' })
                end
            end

            if vim.g.transparent then
                transparent_theme()
            end
        end,
    },
}
