local opt = vim.opt

local options = {
    number = true,                          -- set numbered lines
    relativenumber = true,                  -- set relative numbered lines
    cursorline = true,                      -- highlight the current line

    tabstop = 4,                            -- number of spaces a <Tab> counts for
    softtabstop = 4,                        -- number of spaces inserted when pressing <Tab>
    shiftwidth = 4,                         -- number of spaces used for auto-indent and >> <<

    expandtab = true,                       -- convert tabs to spaces
    autoindent = true,                      -- copy indent from current line to when starting a new one
    breakindent = true,                     -- wrapped lines keep indentation (when wrap is enabled)
    -- smartindent = true,                      -- smarter autoindenting for code
    -- smarttab = true,                         -- makes <Tab>/<BS> behave better with indentation

    wrap = false,                           -- wrap long lines visually instead of extending past the screen
    -- linebreak = true,                        -- companion to wrap, don't split words

    ignorecase = true,                      -- ignore case when searching
    smartcase = true,                       -- override ignorecase if search contains uppercase

    termguicolors = true,                   -- set term gui colors
    background = "dark",                    -- tell colorschemes to use dark background

    signcolumn = "yes",                     -- always show the sign column
    backspace = "indent,eol,start",         -- allow backspace over indent, line breks and start

    splitright = true,                      -- vertical splits open to the right
    splitbelow = true,                      -- horizontal splits open below

    clipboard = "unnamedplus",              -- use system clipboard for yank, delete, paste

    mouse = "a",                            -- allow the mouse to be used in neovim
    scrolloff = 8,                          -- keep 8 lines visible above/below cursor
    sidescrolloff = 8,                      -- same, but horizontally

    completeopt = {"menuone", "noselect"},  -- mostly just for cmp
    pumheight = 10,                         -- limit popup menu height

    hlsearch = true,                        -- highlight search matches
    incsearch = true,                       -- show matches as you type

    swapfile = false,                       -- disable swap files
    backup = false,                         -- disable backup files
    writebackup = false,                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

    showmode = false,                       -- hide -- INSERT -- (statusline shows it) 
    cmdheight = 1,                          -- adjust command line height

    undofile = true,                        -- persist undo history across sessions
    undolevels = 10000,                     -- adjust undo history

    updatetime = 250,                       -- faster CursorHold events (default is 4000ms)
    timeoutlen = 300,                       -- time to wait for a mapped sequence to complete (in ms)
}

for k, v in pairs(options) do
    opt[k] = v
end

vim.g.netrw_liststyle = 3

