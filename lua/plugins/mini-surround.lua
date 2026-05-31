-- 环绕编辑 (surround)
return {
    {
        'nvim-mini/mini.surround',
        event = 'InsertEnter',
        config = function()
            require('mini.surround').setup()
        end,
    },
}
