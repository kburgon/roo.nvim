local plugin = require("roo.utils")

describe("roo.utils", function ()
	before_each(function ()
		vim.g.buffer_collection = {}
	end)

	it('set: buffer is saved to variable', function ()
		local index = 1
		local bufnum = vim.api.nvim_get_current_buf()
		local success = plugin.set(index, bufnum)
		assert.is_true(success)
		assert.equals(bufnum, vim.g.buffer_collection[index])
	end)

	it('set: buffer is set without being specified', function ()
		local index = 5
		local bufnum = vim.api.nvim_get_current_buf()
		local success = plugin.set(index)
		assert.is_true(success)
		assert.equals(bufnum, vim.g.buffer_collection[index])
	end)

	it('set: multiple buffers can be set', function ()
		local indices = { 1, 4 }
		local bufnums = {}
		for i, index in ipairs(indices) do
			local newbuf = vim.api.nvim_create_buf(true, true)
			table.insert(bufnums, i, newbuf)
			local success = plugin.set(index, newbuf)
			assert.is_true(success)
		end

		-- reiterate through the loop as clear demonstration that the values saved
		for i, index in ipairs(indices) do
			assert.equals(bufnums[i], vim.g.buffer_collection[index])
		end
	end)

	it('set: buffers are overwritten', function ()
		local index = 2
		local firstbuf = vim.api.nvim_create_buf(true, true)
		local secondbuf = vim.api.nvim_create_buf(true, true)
		local firstSuccess = plugin.set(index, firstbuf)
		assert.equals(firstbuf, vim.g.buffer_collection[index])
		local secondSuccess = plugin.set(index, secondbuf)
		assert.equals(secondbuf, vim.g.buffer_collection[index])
	end)
end)
