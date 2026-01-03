M = {}

local function ensure_collection()
	if vim.g.buffer_collection == nil then
		vim.g.buffer_collection = {}
	end
end

-- Assign a buffer to a specific index in the collection
-- @param index: number - The index to assign the buffer to
-- @param buffer: number|nil - The buffer number (defaults to the current buffer)
function M.set(index, buffer)
	ensure_collection()
	local bufnr = buffer or vim.api.nvim_get_current_buf()

	if not vim.api.nvim_buf_is_valid(bufnr) then
		vim.notify(string.format("Buffer %d is not valid", bufnr), vim.log.levels.ERROR)
		return false
	end

	local collection = vim.g.buffer_collection
	collection[index] = bufnr
	vim.g.buffer_collection = collection

	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname == "" then
		bufname = "[No Name]"
	end

	vim.notify(
		string.format("Buffer %d (%s) assigned to index %d", bufnr, bufname, index),
		vim.log.levels.INFO
	)

	return true
end



return M
