local global_autocmd_group = require('utils.autocmd').global_autocmd_group

vim.api.nvim_create_autocmd('TextYankPost', {
    group = global_autocmd_group,
    desc = '复制文本后高亮提示',
    callback = function()
        -- 300ms 高亮，颜色同搜索
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    group = global_autocmd_group,
    desc = '打开文件自动恢复上次光标位置 + 展开折叠',
    callback = function()
        vim.api.nvim_exec2('silent! normal! g`"zv', { output = false })
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = global_autocmd_group,
    desc = '禁用新行自动延续注释格式',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = global_autocmd_group,
    desc = 'Markview: 清空 foldtext 避免插件冲突',
    pattern = 'markdown',
    callback = function()
        vim.opt.foldtext = ''
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = global_autocmd_group,
    desc = '为除 Markdown 外的文件类型启用自定义折叠文本',
    pattern = '*',
    callback = function()
        if vim.bo.filetype ~= 'markdown' then
            vim.opt.foldtext = 'v:lua.custom_foldtext()'
        end
    end,
})
