local utils = require("gitblame.utils")

describe("gitblame.utils", function()
    describe("truncate_description", function()
        it("should return full text when max_length is 0", function()
            local result = utils.truncate_description("Hello, World!", 0)
            assert.are.equal("Hello, World!", result)
        end)

        it("should return full text when shorter than max_length", function()
            local result = utils.truncate_description("Short", 10)
            assert.are.equal("Short", result)
        end)

        it("should truncate text when longer than max_length", function()
            local result = utils.truncate_description("This is a long description", 10)
            assert.are.equal("This is a ...", result)
        end)

        it("should return full text when equal to max_length", function()
            local result = utils.truncate_description("12345", 5)
            assert.are.equal("12345", result)
        end)

        it("should handle empty string", function()
            local result = utils.truncate_description("", 5)
            assert.are.equal("", result)
        end)
    end)

    describe("shallowcopy", function()
        it("should copy a table", function()
            local original = { a = 1, b = 2, c = "hello" }
            local copy = utils.shallowcopy(original)
            assert.are.same(original, copy)
            assert.are_not.equal(original, copy)
        end)

        it("should not deep copy nested tables", function()
            local inner = { x = 1 }
            local original = { a = inner }
            local copy = utils.shallowcopy(original)
            assert.are.equal(original.a, copy.a) -- same reference
        end)

        it("should copy non-table values directly", function()
            assert.are.equal(42, utils.shallowcopy(42))
            assert.are.equal("hello", utils.shallowcopy("hello"))
            assert.are.equal(true, utils.shallowcopy(true))
        end)
    end)

    describe("merge_map", function()
        it("should merge source entries into target", function()
            local target = { a = 1, b = 2 }
            local source = { c = 3, d = 4 }
            utils.merge_map(source, target)
            assert.are.same({ a = 1, b = 2, c = 3, d = 4 }, target)
        end)

        it("should overwrite existing keys", function()
            local target = { a = 1, b = 2 }
            local source = { b = 99 }
            utils.merge_map(source, target)
            assert.are.same({ a = 1, b = 99 }, target)
        end)

        it("should handle empty source", function()
            local target = { a = 1 }
            utils.merge_map({}, target)
            assert.are.same({ a = 1 }, target)
        end)
    end)

    describe("get_filepath", function()
        it("should return nil for empty buffer name", function()
            -- Create an unnamed buffer
            vim.cmd("enew!")
            local result = utils.get_filepath()
            assert.is_nil(result)
        end)

        it("should return nil for terminal buffers", function()
            -- Mock a buffer with a term:// prefix name
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_name(buf, "term://some-command")
            vim.api.nvim_set_current_buf(buf)

            local result = utils.get_filepath()
            assert.is_nil(result)

            -- Clean up
            vim.api.nvim_buf_delete(buf, { force = true })
        end)
    end)
end)
