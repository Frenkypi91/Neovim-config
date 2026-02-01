------------------------------------------------------------
-- Autocommands
------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Small helper to check if current buffer is a real file buffer
local function is_real_file(bufnr)
bufnr = bufnr or 0
local bt = vim.bo[bufnr].buftype
return bt == "" or bt == "acwrite"
end

------------------------------------------------------------
-- Enforce spaces & sane defaults everywhere
------------------------------------------------------------
autocmd({ "BufEnter", "FileType" }, {
    group = augroup("ForceSpaces", { clear = true }),
        callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.autoindent = true
        vim.opt_local.smartindent = true
        end,
})

-- Filetype overrides
autocmd("FileType", {
    group = augroup("FTOverrides", { clear = true }),
        callback = function(args)
        local ft = vim.bo[args.buf].filetype

        -- Python
        if ft == "python" then
            vim.opt_local.shiftwidth = 4
            vim.opt_local.tabstop = 4
            vim.opt_local.softtabstop = 4
            vim.opt_local.textwidth = 88
            vim.opt_local.colorcolumn = "89"
            return
            end

            -- Julia:
            if ft == "julia" then
                vim.opt_local.textwidth = 92
                vim.opt_local.colorcolumn = "93"
                return
                end

                -- R
                if ft == "r" or ft == "rmd" or ft == "quarto" then
                    vim.opt_local.textwidth = 100
                    vim.opt_local.colorcolumn = "101"
                    return
                    end

                    -- C/C++
if ft == "c" or ft == "cpp" then
    vim.opt_local.textwidth = 100
    vim.opt_local.colorcolumn = "101"
    return
    end

    -- Fortran
    if ft == "fortran" then
        vim.opt_local.textwidth = 100
        vim.opt_local.colorcolumn = "101"
        return
        end
        end,
})

------------------------------------------------------------
-- Quality of life
------------------------------------------------------------

-- Highlight text after yank
autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
        callback = function()
        vim.highlight.on_yank({ timeout = 200 })
        end,
})

-- Auto-reload if file changed outside Neovim
autocmd({ "FocusGained", "BufEnter" }, {
    group = augroup("AutoCheckTime", { clear = true }),
        command = "checktime",
})

-- Auto-create missing directories on save
autocmd("BufWritePre", {
    group = augroup("AutoMkdir", { clear = true }),
        callback = function()
        if not is_real_file(0) then return end
            local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
            if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
                pcall(vim.fn.mkdir, dir, "p")
                end
                end,
})

-- Terminal buffers
autocmd("TermOpen", {
    group = augroup("TerminalSettings", { clear = true }),
        callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd("startinsert")
        end,
})

-- Close some “utility” windows with q
autocmd("FileType", {
    group = augroup("CloseWithQ", { clear = true }),
        pattern = { "help", "qf", "lspinfo", "man", "checkhealth" },
        callback = function()
        vim.bo.buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
        end,
})

------------------------------------------------------------
-- Clean whitespace
------------------------------------------------------------
autocmd("BufWritePre", {
    group = augroup("TrimWhitespace", { clear = true }),
        pattern = {
            "*.py", "*.jl", "*.r", "*.R", "*.rs",
            "*.c", "*.h", "*.cpp", "*.hpp",
            "*.f", "*.f90", "*.F90",
            "*.tex", "*.md", "*.lua",
            "*.html", "*.css", "*.scss",
        },
        command = "%s/\\s\\+$//e",
})

-- Highlight trailing whitespace only outside Insert mode
autocmd("InsertLeave", {
    group = augroup("WhitespaceHighlight", { clear = true }),
        command = "match ErrorMsg /\\s\\+$/",
})
autocmd("InsertEnter", {
    group = augroup("WhitespaceHighlight", { clear = true }),
        command = "match none",
})

------------------------------------------------------------
-- Format on save (SAFE TOOLCHAIN)
------------------------------------------------------------
-- Order:
--   1) LSP format (if available)
--   2) Ruff for Python
--   3) Stylua for Lua
--   4) JuliaFormatter for Julia (optional)
------------------------------------------------------------

autocmd("BufWritePre", {
    group = augroup("SafeFormatOnSave", { clear = true }),
        pattern = {
            "*.py", "*.jl", "*.lua",
            "*.r", "*.R",
            "*.rs",
            "*.c", "*.h", "*.cpp", "*.hpp",
            "*.f", "*.f90", "*.F90",
            "*.tex",
            "*.html", "*.css", "*.scss",
            "*.md",
        },
        callback = function()
        if not is_real_file(0) then return end

            local ft = vim.bo.filetype
            local file = vim.api.nvim_buf_get_name(0)

            -- Avoid being too aggressive on huge files
            local ok, st = pcall(vim.loop.fs_stat, file)
            if ok and st and st.size and st.size > 800 * 1024 then
                return
                end

                -- 1) LSP format
pcall(function()
vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
end)

-- 2) Python
if ft == "python" and vim.fn.executable("ruff") == 1 then
    pcall(vim.fn.system, { "ruff", "format", file })
    pcall(vim.fn.system, { "ruff", "check", "--fix", "--select", "I", file })
    end

    -- 3) Lua
    if ft == "lua" and vim.fn.executable("stylua") == 1 then
        pcall(vim.fn.system, { "stylua", file })
        end

        -- 4) Julia
if ft == "julia" and vim.fn.executable("julia") == 1 then
    pcall(vim.fn.system, {
        "julia", "--startup-file=no", "--history-file=no", "-e",
        [[
            try
            using JuliaFormatter
            format_file(ARGS[1]; indent=2)
                catch
                end
        ]],
        file
    })
    end

    -- Reload if an external formatter touched the file
    pcall(vim.cmd, "checktime")
    end,
})

------------------------------------------------------------
-- LaTeX
------------------------------------------------------------
autocmd("FileType", {
    group = augroup("LaTeXUX", { clear = true }),
        pattern = "tex",
        callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 2
        vim.opt_local.textwidth = 0
        end,
})
