-- per-filetype indentation, overriding the global width from core.options
local indent_widths = {
    [2] = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "qml",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
}

local indent_group = vim.api.nvim_create_augroup("IndentWidths", { clear = true })

for width, filetypes in pairs(indent_widths) do
    vim.api.nvim_create_autocmd("FileType", {
        group = indent_group,
        pattern = filetypes,
        callback = function()
            vim.bo.tabstop = width
            vim.bo.softtabstop = width
            vim.bo.shiftwidth = width
        end,
    })
end
