local dashboard = require("alpha.themes.dashboard")

local function read_ascii_art(filepath)
    local lines = {}
    for line in io.lines(filepath) do
            table.insert(lines, line)
    end
    return lines
end

local ascii_art_path = vim.fn.stdpath('config') .. '/lua/core/art/mountain.txt'
dashboard.section.header.val = read_ascii_art(ascii_art_path)

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = "#ffc080"})
dashboard.section.header.opts = {
    position = "center",
    hl = "DashboardHeader"
}

dashboard.section.buttons.val = {
    -- dashboard.button("SPC wr", "  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
    dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
    dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
    dashboard.button("SPC ff", "  > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"), 
    dashboard.button("q", "  > Quit vim", "<cmd>qa<CR>"),
}


dashboard.section.buttons.opts = {
    hl = "DashboardHeader"
}

-- Send config to alpha
require("alpha").setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
