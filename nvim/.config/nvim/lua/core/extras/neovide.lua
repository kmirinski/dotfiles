vim.print(vim.g.neovide_version)

-- Put anything you want to happen only in Neovide here
vim.o.guifont = "FiraCode Nerd Font Mono:h12"

-- vim.g.neovide_text_gamma = 0.0
-- vim.g.neovide_text_contrast = 0.5

vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_right = 1
vim.g.neovide_padding_left = 1

-- vim.g.neovide_input_macos_option_key_is_meta = 'both'
-- Helper function for transparency formatting
-- local alpha = function()
--     return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
-- end
-- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_opacity = 0.5
-- vim.g.transparency = 0.8
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_opacity = 0.9
vim.g.neovide_normal_opacity = 0.9

-- vim.g.neovide_window_blurred = true
-- vim.g.neovide_floating_blur_amount_x = 4.0
-- vim.g.neovide_floating_blur_amount_y = 4.0

vim.g.neovide_show_border = false

-- local default_path = vim.fn.expand("~/")
-- vim.api.nvim_set_current_dir(default_path)

-- vim.g.neovide_theme = 'auto'

vim.g.neovide_remember_window_size = true

local function set_guifont_size(size)
    assert(type(size) == "number", "size must be a number")
    local name = "FiraCode Nerd Font Mono"
    vim.o.guifont = string.format("%s:h%d", name, size)
end

-- create a user command so you can do :SetFontSize 14
vim.api.nvim_create_user_command("SetFontSize", function(ctx)
    local n = tonumber(ctx.args)
    if not n then
        vim.notify("Invalid font size: " .. ctx.args, vim.log.levels.ERROR)
        return
    end
    set_guifont_size(n)
    vim.notify("GUIfont set to " .. vim.o.guifont, vim.log.levels.INFO)
end, {
    nargs = 1,
    desc  = "Set the GUI font size (e.g. :SetFontSize 12)"
})

