-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- tokyonight-night
            -- tokyonight-storm
            -- tokyonight-day
            -- tokyonight-moon

            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
}
