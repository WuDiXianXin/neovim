-- ==================== 诊断 & LSP 相关 ====================
local nmap = require('utils.keymap').nmap
nmap('<leader>q', vim.diagnostic.setloclist, '所有诊断填充到位置列表')
nmap('<leader>l', function()
    local winid = vim.fn.getloclist(0, { winid = 0 }).winid
    if winid == 0 then
        vim.cmd('lopen')
    else
        vim.cmd('lclose')
    end
end, '打开/关闭位置列表')

nmap('<leader>lg', ':lvimgrep', '精准导航搜索 → 位置列表')

nmap('K', vim.lsp.buf.hover, '显示悬浮文档')
nmap('grd', vim.lsp.buf.definition, '跳转定义')
nmap('grD', vim.lsp.buf.declaration, '跳转声明')
nmap('grr', vim.lsp.buf.references, '查找所有引用')
nmap('gri', vim.lsp.buf.implementation, '跳转实现')
nmap('grn', vim.lsp.buf.rename, '全局重命名')
nmap('gra', vim.lsp.buf.code_action, '代码动作')
nmap('grt', vim.lsp.buf.type_definition, '跳转类型定义')
nmap('<leader>lf', vim.lsp.buf.format, '格式化当前文件')

-- 诊断
vim.diagnostic.config({
    virtual_text = true, -- 在行尾显示错误信息
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
        severity = { min = vim.diagnostic.severity.HINT },
    },
    underline = true,
    update_in_insert = false, -- 插入模式下不实时更新
    severity_sort = true, -- 按严重程度排序
    float = { -- 悬浮窗口样式
        source = 'always',
        border = 'rounded',
        header = '',
    },
})

-- 内联提示（Inline Hint） - 强烈推荐打开
vim.lsp.inlay_hint.enable(true) -- Neovim 0.10+

-- 自动悬浮窗口（鼠标悬停或光标停留时显示文档）
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- ================== LSP 配置 ==================
-- lua_ls 配置
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },

    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },

            diagnostics = {
                -- globals = { "vim", "describe", "it", "before_each", "after_each", "pending" },
                globals = { 'vim' },
            },

            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                },
            },

            telemetry = { enable = false },

            hint = { -- Inline Hint
                enable = true,
                arrayIndex = 'Auto',
                setType = true,
                paramName = 'All',
                paramType = true,
                await = true,
            },
        },
    },
})

-- clangd 配置
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--all-scopes-completion',
        '--pch-storage=memory',
        '--enable-config',
        '--fallback-style=llvm',
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },

    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },

    root_markers = {
        '.clangd',
        'compile_commands.json',
        'compile_flags.txt',
        '.git',
        'CMakeLists.txt',
        'MakeFile',
        'meson.build',
    },

    capabilities = {
        textDocument = {
            semanticTokens = { multilineTokenSupport = true },
            inlayHint = {
                dynamicRegistration = true,
            },
            foldingRange = { -- 按行折叠
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
        offsetEncoding = { 'utf-8', 'utf-16' },
    },

    settings = {
        clangd = {
            fallbackFlags = { '-std=c++23' },
            index = {
                onChange = true, -- 文件修改时立即更新索引
            },
            completion = {
                insertInclude = true, -- 自动插入 #include
            },
            inlayHints = {
                enabled = true, -- 总开关
                parameterNames = true, -- 参数名称提示
                deducedTypes = true, -- 推导类型提示
                typeElaborations = true, -- 更详细的类型提示
                designators = true, -- 聚合初始化提示
                blockEnd = false, -- 是否显示 } 后的提示（一般关掉）
            },
        },
    },
})

--- pyright 配置
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyrightconfig.json',
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})

-- ================== 统一处理 LspAttach ==================
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_attach_keymaps', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        local bufnr = args.buf

        -- ================== Pyright 专用命令 ==================
        if client.name == 'pyright' then
            -- Organize Imports
            vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
                local params = {
                    command = 'pyright.organizeimports',
                    arguments = { vim.uri_from_bufnr(bufnr) },
                }
                client:request('workspace/executeCommand', params, nil, bufnr)
            end, { desc = 'Pyright: Organize Imports' })

            -- Set Python Path
            vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', function(command)
                local path = command.args
                if client.settings then
                    client.settings.python =
                        vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
                else
                    client.config.settings =
                        vim.tbl_deep_extend('force', client.config.settings or {}, { python = { pythonPath = path } })
                end
                client:notify('workspace/didChangeConfiguration', { settings = nil })
            end, {
                desc = 'Pyright: Set Python Path',
                nargs = 1,
                complete = 'file',
            })
        end

        -- 你未来可以在这里继续添加其他 LSP 的特殊处理
    end,
})

vim.lsp.enable({ 'lua_ls', 'clangd', 'pyright' })
