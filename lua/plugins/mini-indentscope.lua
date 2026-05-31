-- 缩进范围显示
return {
    {
        'nvim-mini/mini.indentscope',
        event = 'BufReadPost',
        config = function()
            require('mini.indentscope').setup({
                symbol = '▏', -- 或 '│' 等细线
                options = {
                    try_as_border = true, -- ★ 必须！让头部行（如 if/for/def）被识别为边界，从而能缩小到内层
                    indent_at_cursor = true, -- 光标左右移动时动态调整参考缩进
                    border = 'both',
                },
                draw = {
                    delay = 50,
                    animation = require('mini.indentscope').gen_animation.none(), -- 关动画，避免延迟迷惑
                    predicate = function()
                        return true
                    end, -- 测试阶段强制画所有（可选）
                },
            })
        end,
    },
}
