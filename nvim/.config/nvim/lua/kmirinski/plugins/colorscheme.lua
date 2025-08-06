return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        local transparent = true

        local bg = '#1a1b26'
        local bg_dark = "#011423"
        local bg_highlight = "#143652"
        local bg_search = "#0A64AC"
        local bg_visual = "#275378"
        local fg = "#CBE0F0"
        local fg_dark = "#B4D0E9"
        local fg_gutter = "#627E97"
        local border = "#547998"       

        require("tokyonight").setup({
            style = "night",
            transparent = transparent,
            styles = {
                sidebars = transparent and "transparent" or "dark",
                floats = transparent and "transparent" or "dark",
            },
            on_colors = function(colors)
                colors.bg = bg
                colors.bg_dark = transparent and colors.none or bg_dark
                colors.bg_float = transparent and colors.none or bg_dark
                colors.bg_highlight = bg_highlight
                colors.bg_popup = bg_dark
                colors.bg_search = bg_search
                colors.bg_sidebar = transparent and colors.none or bg_dark
                colors.bg_statusline = transparent and colors.none or bg_dark
                colors.bg_visual = bg_visual
                colors.border = border
                colors.fg = fg
                colors.fg_dark = fg_dark
                colors.fg_float = fg
                colors.fg_gutter = fg_gutter
                colors.fg_sidebar = fg_dark
            end,
        })

        vim.cmd("colorscheme tokyonight")

        if transparent then
            vim.cmd([[
                highlight Normal guibg=NONE ctermbg=NONE
                highlight NormalNC guibg=NONE ctermbg=NONE
                highlight NormalFloat guibg=NONE ctermbg=NONE
                highlight FloatBorder guibg=NONE ctermbg=NONE
                highlight SignColumn guibg=NONE ctermbg=NONE
                highlight VertSplit guibg=NONE ctermbg=NONE
                highlight StatusLine guibg=NONE ctermbg=NONE
                highlight LineNr guibg=NONE ctermbg=NONE
            ]])
        end

    end,
}
