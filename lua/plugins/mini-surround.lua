-- 环绕编辑 (surround)
return {
    {
        'nvim-mini/mini.surround',
        event = 'VeryLazy',
        config = function()
            require('mini.surround').setup()
        end,
    },
}
