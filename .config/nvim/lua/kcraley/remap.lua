-- Change leader to spacebar.
vim.g.mapleader = " "

-- Jump to netrw explorer.
vim.keymap.set("n", "<leader>f", vim.cmd.Explore)

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
