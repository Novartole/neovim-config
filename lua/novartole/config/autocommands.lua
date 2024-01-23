local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd.wincmd("=")
	end,
})
