return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",

				-- I'm not convinced the below options do anything.
				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					enable = true,
				},
			})
			require("nvim-treesitter").install({
				"bash",
				"go",
				"hyprlang",
				"lua",
				"python",
				"rust",
				"yaml",
			})
			require("nvim-treesitter").update():wait(300000)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}
