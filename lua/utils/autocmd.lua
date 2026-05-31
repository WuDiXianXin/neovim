-- 创建全局 autocmd 组
local M = {}
M.global_autocmd_group = vim.api.nvim_create_augroup('global_autocmd_group', { clear = true })
return M
