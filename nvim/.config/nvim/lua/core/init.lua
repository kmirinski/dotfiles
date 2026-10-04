require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lsp")

if vim.g.neovide then
    require("core.extras.neovide")
end

