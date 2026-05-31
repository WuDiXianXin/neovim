-- LSP 大纲视图
return {
    {
        'hedyhli/outline.nvim',
        event = 'LspAttach',
        config = function()
            require('outline').setup()
            local nmap = require('utils.keymap').nmap
            nmap('<leader>ol', '<cmd>topleft Outline<CR>', '打开 Outline')
        end,
    },
}
