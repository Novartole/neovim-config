vim.g.mapleader = " " -- set <leader>

local keymap = vim.keymap
local cmd = vim.cmd

keymap.set("n", "x", '"_x', { desc = "Don't copy x'ed symbol into copy/paste buffer" })
keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in place after J in v mode" })
keymap.set("x", "<leader>p", [["_dP]], { desc = "Don't save replaced block to paste the original one" })
keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "start substitute a word under cursor" }
)
keymap.set("n", "<leader>ww", ":se wrap!<CR>", { desc = "Toggle wrapping", silent = true })

-- window splitting
--
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", cmd.close, { desc = "Close current split window", silent = true })

-- tabs
--
keymap.set("n", "<leader>to", cmd.tabnew, { desc = "Open new tab" })
keymap.set("n", "<leader>tx", cmd.tabclose, { desc = "Close current tab" })
keymap.set("n", "<leader>tn", cmd.tabn, { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", cmd.tabp, { desc = "Go to previous tab" })

-- buffers
--
keymap.set("n", "[b", cmd.bprevious, { desc = "Prev buffer" })
keymap.set("n", "]b", cmd.bnext, { desc = "Next buffer" })

-- better indenting
--
keymap.set("v", "<", "<gv", { desc = "Move left" })
keymap.set("v", ">", ">gv", { desc = "Move right" })

-- move highlighted lines in v mode
--
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move down", silent = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move up", silent = true })
