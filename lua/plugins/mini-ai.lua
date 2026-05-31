-- 文本对象增强 (ai)
return {
    {
        'nvim-mini/mini.ai',
        event = 'InsertEnter',
        config = function()
            require('mini.ai').setup({
                n_lines = 500,
                search_method = 'cover_or_next',
            })
        end,
    },
}
