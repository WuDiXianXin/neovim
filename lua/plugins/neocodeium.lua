-- NeoCodeium AI 代码补全
return {
    {
        'monkoose/neocodeium',
        keys = {
            { '<leader>ane', mode = 'n' },
        },
        config = function()
            local neocodeium = require('neocodeium')
            neocodeium.setup({
                -- enabled = false,
                manual = false,
                show_label = true,
                debounce = false,
                max_lines = 10000,
                silent = false,
                disable_in_special_buftypes = true,
                filter = function()
                    return not require('blink.cmp').is_visible()
                end,
                log_level = 'warn',
                single_line = {
                    enabled = false,
                    label = '...', -- 表示存在多行建议的标签
                },
                filetypes = {
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    ['.'] = false,
                },
                -- 用于为 Windsurf Chat 检测工作区根目录的目录和文件列表
                root_dir = {
                    '.bzr',
                    '.git',
                    '.hg',
                    '.svn',
                    '_FOSSIL_',
                    'package.json',
                    'pom.xml',
                    'Cargo.toml',
                    'CMakeLists.txt',
                    'Makefile',
                    'configure',
                    'meson.build',
                    'compile_commands.json',
                },
            })

            -- local nmap = require('utils.keymap').nmap
            local imap = require('utils.keymap').imap
            imap('<leader>aa', neocodeium.accept, 'AI: 接受建议')
            imap('<leader>al', neocodeium.accept_line, 'AI: 接受一行建议')
            imap('<leader>an', neocodeium.cycle_or_complete, 'AI: 切换下一个建议')
            -- nmap('<leader>ane', '<cmd>NeoCodeium enable<CR>', 'AI: 启动 NeoCodeium 服务')
        end,
    },
}
