local M = {}

function M.setup()
	vim.ap.nvim_create_user_command("RooSet", function (cmd)
		local args = vim.split(cmd.args, " ", { trimempty = true })
		local index = tonumber(args[1])
		local bufnr = args[2] and tonumber(args[2]) or nil

		if not index then
			vim.notify("Usage: RooSet <index> [buffer]", vim.log.levels.ERROR)
			return
		end

		-- TODO: Call util func to set the buffer mapping
	end, { nargs = "2", desc = "Set buffer to index" })

	vim.api.nvim_create_user_command("RooJump", function (cmd)
		local index = tonumber(cmd.args)

		if not index then
			vim.notify("Usage: RooJump <index>", vim.log.levels.ERROR)
			return
		end

		-- TODO: Call util func to jump to the buffer mapping
	end, { nargs = 1, desc = "Jump to indexed buffer" })

	vim.api.nvim_create_user_command("RooList", function ()
		-- TODO: Call util func to list all indexed buffers
	end, { desc = "List all indexed buffers"})
end

return M
