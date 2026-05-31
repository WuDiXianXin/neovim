-- Markdown 增强
return {
    {
        'OXY2DEV/markview.nvim',
        ft = 'markdown',
        config = function()
            local presets = require('markview.presets')

            require('markview').setup({
                markdown = {
                    headings = presets.headings.arrowed,
                    -- 如果你以后想同时显示箭头 + 编号，可以取消下面这行的注释
                    -- headings = vim.tbl_deep_extend("force", presets.headings.arrowed, presets.headings.numbered),

                    horizontal_rules = presets.horizontal_rules.arrowed,
                    tables = presets.tables.rounded,
                    checkboxes = presets.checkboxes.nerd,
                },
            })

            local nmap = require('utils.keymap').nmap
            nmap('<leader>M', '<cmd>Markview<CR>', '全局完全开关 Markview 渲染')
            nmap('<leader>m', '<cmd>Markview toggle<CR>', '只切换当前 Markdown 文件的渲染')
            nmap('<leader>ms', '<cmd>Markview splitToggle<CR>', '打开/关闭分屏实时预览')
        end,
    },
}
