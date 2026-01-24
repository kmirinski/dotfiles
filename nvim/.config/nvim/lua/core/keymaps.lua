local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap("v", "p", '"_dP', { desc = "When pasting on top of something, do not overwrite top of clipboard" })

-- normal --

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- resize with arrows
keymap("n", "<C-Up>", ":resize +1<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Down>", ":resize -1<CR>", { desc = "Increase window height" })
keymap("n", "<C-Left>", ":vertical resize -1<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +1<CR>", { desc = "Increase window width" })

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })

-- window management
keymap("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"})
keymap("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
keymap("n", "<leader>se", "<C-w>=", {desc = "Make windows equal size"})
keymap("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current split"})

-- tabs management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", {desc = "Close current tab"})
keymap("n", "<leader>tn", "<cmd>tabn<CR>", {desc = "Go to next tab"})
keymap("n", "<leader>tp", "<cmd>tabp<CR>", {desc = "Go to previous tab"})
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"})

-- move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })

-- visual --

-- indent
keymap("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })
keymap("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })

-- move text up and down 
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- visual block mode --

-- move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
keymap("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down (Alt)" })
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up (Alt)" })


