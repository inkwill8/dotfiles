return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({ "lua", "javascript", "cpp", "c", "html", "css", "bash", "ruby" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "javascript", "cpp", "c", "html", "css", "bash", "ruby" },
			callback = function()
				vim.treesitter.start()
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "javascript", "cpp", "c", "html", "css", "bash", "ruby" },
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
