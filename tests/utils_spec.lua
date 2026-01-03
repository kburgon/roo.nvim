local plugin = require("roo.utils")

describe("roo.utils.set", function ()
	before_each(function ()
		vim.g.buffer_collection = {}
	end)

	it('buffer is saved to variable', function ()
		local index = 1
		local bufnum = vim.api.nvim_get_current_buf()
		local success = plugin.set(index, bufnum)
		assert.is_true(success)
		assert.equals(bufnum, vim.g.buffer_collection[index])
	end)

	it('buffer is set without being specified', function ()
		local index = 5
		local bufnum = vim.api.nvim_get_current_buf()
		local success = plugin.set(index)
		assert.is_true(success)
		assert.equals(bufnum, vim.g.buffer_collection[index])
	end)

	it('multiple buffers can be set', function ()
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

	it('buffers are overwritten', function ()
		local index = 2
		local firstbuf = vim.api.nvim_create_buf(true, true)
		local secondbuf = vim.api.nvim_create_buf(true, true)
		plugin.set(index, firstbuf)
		assert.equals(firstbuf, vim.g.buffer_collection[index])
		plugin.set(index, secondbuf)
		assert.equals(secondbuf, vim.g.buffer_collection[index])
	end)
end)

describe("roo.utils.jump", function ()
	before_each(function ()
		vim.g.buffer_collection = {}
	end)

	it('valid buffer is jumped to', function ()
		local jumpindex = 3
		local collection = {}
		for _ = 1, 5, 1 do
			table.insert(collection, vim.api.nvim_create_buf(true, true))
		end

		vim.g.buffer_collection = collection

		local success = plugin.jump(jumpindex)
		assert.is_true(success)
		local curbuf = vim.api.nvim_get_current_buf()
		local indexbuf = vim.g.buffer_collection[jumpindex]
		assert.equals(indexbuf, curbuf)
	end)

	it('invalid buffer is removed', function ()
		local index = 1
		local bufnum = 999999
		local collection = { bufnum }
		vim.g.buffer_collection = collection
		local success = plugin.jump(index)
		assert.is_false(success)
		assert.equals(nil, vim.g.buffer_collection[index])
	end)

	it('failure returned on nil buffer', function ()
		local index = 999999
		local success = plugin.jump(index)
		assert.is_false(success)
	end)
end)
