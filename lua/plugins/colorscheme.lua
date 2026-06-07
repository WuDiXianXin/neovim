-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- moon, night, storm, day
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
}
