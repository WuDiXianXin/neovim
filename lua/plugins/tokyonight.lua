-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- require('tokyonight').setup()
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
}
