local global_autocmd_group = require('utils.autocmd').global_autocmd_group

local api = vim.api
local autocmd = api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = global_autocmd_group,
    desc = '复制文本后高亮提示',
    callback = function()
        -- 300ms 高亮，颜色同搜索
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 300 })
    end,
})

autocmd({ 'BufReadPost' }, {
    group = global_autocmd_group,
    desc = '打开文件自动恢复上次光标位置 + 展开折叠',
    callback = function()
        api.nvim_exec2('silent! normal! g`"zv', { output = false })
    end,
})

autocmd('BufEnter', {
    group = global_autocmd_group,
    desc = '禁用新行自动延续注释格式',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

autocmd('LspAttach', {
    group = global_autocmd_group,
    desc = '禁用所有 lsp 自带的语法高亮',
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

autocmd('FileType', {
    group = global_autocmd_group,
    desc = 'Markview: 清空 foldtext 避免插件冲突',
    pattern = 'markdown',
    callback = function()
        vim.opt.foldtext = ''
    end,
})

autocmd('FileType', {
    group = global_autocmd_group,
    desc = '为除 Markdown 外的文件类型启用自定义折叠文本',
    pattern = '*',
    callback = function()
        if vim.bo.filetype ~= 'markdown' then
            vim.opt.foldtext = 'v:lua.custom_foldtext()'
        end
    end,
})

-- autocmd('BufWinEnter', {
--     group = global_autocmd_group,
--     desc = '禁用 dap-ui 的窗口 winbar',
--     pattern = '*',
--     callback = function()
--         -- 'dapui_scopes',
--         -- 'dapui_breakpoints',
--         -- 'dapui_stacks',
--         -- 'dapui_watches',
--         -- 'dapui_repl',
--         -- 'dapui_console',
--
--         -- 'dap-repl',
--
--         local ft = vim.bo.filetype
--         if ft == 'dap-repl' then
--             vim.opt_local.winbar = ''
--         end
--     end,
-- })
