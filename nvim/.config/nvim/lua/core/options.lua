
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

local options = {
    number = true,                      -- set numbered lines
    relativenumber = true,              -- set relative numbered lines
    cursorline = true,                  -- highlight the current line

    tabstop = 4,                        -- number of spaces a <Tab> counts for
    softtabstop = 4,                    -- number of spaces inserted when pressing <Tab>
    shiftwidth = 4,                     -- number of spaces used for auto-indent and >> <<

    expandtab = true,                   -- convert tabs to spaces
    autoindent = true,                  -- copy indent from current line to when starting a new one
    smartindent = true,                 -- smarted autoindenting for code
    smarttab = true,                    -- makes <Tab>/<BS> behave better with indentation

    wrap = true,                        -- display lines as one long line
    linebreak = true,                   -- companion to wrap, don't split words

    ignorecase = true,                  -- ignore case when searching
    smartcase = true,                   -- override ignorecase if search contains uppercase

    termguicolors = true,               -- set term gui colors
    background = "dark",                -- tell colorschemes to use dark background

    signcolumn = "yes",                 -- always show the sign column
    backspace = "indent,eol,start",     -- allow backspace over indent, line breks and start

    splitright = true,                  -- vertical splits open to the right
    splitbelow = true,                  -- horizontal splits open below

    clipboard = "unnamedplus",          -- use system clipboard for yank, delete, paste
}

for k, v in pairs(options) do
    opt[k] = v
end

