return {
    'arborist-ts/arborist.nvim',
    event = 'VeryLazy',
    config = function()
        require('arborist').setup({
            -- 常用选项（默认值已很友好）
            prefer_wasm = false, -- 优先使用 WASM（更安全、沙箱化）
            update_cadence = 'daily', -- "daily" | "weekly" | "manual"
            install_popular = false, -- 启动时自动安装常用语言解析器

            -- 额外在启动时安装的语言
            ensure_installed = {
                'c',
                'cpp',
                'rust',
                'markdown',
                'markdown_inline',

                'bash',
                'fish',

                'regex',

                'kdl',
                'yaml',
                'toml',
            },

            -- 禁用某些功能的 TS 支持
            disable = {
                indent = { 'markdown' }, -- 关闭 markdown 的缩进
                -- highlight = { 'csv' }, -- 关闭 csv 的高亮
            },
        })
    end,
}
