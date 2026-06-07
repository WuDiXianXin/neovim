-- 颜色主题
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        -- config = function()
        -- moon, night, storm, day
        -- vim.cmd([[colorscheme tokyonight-moon]])
        -- end,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
            })

            -- latte, frappe, macchiato, mocha
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
}
