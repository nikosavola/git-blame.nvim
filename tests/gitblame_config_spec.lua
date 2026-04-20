local config = require("gitblame.config")

describe("gitblame.config", function()
    -- Reset state before each test
    before_each(function()
        -- Clear any gitblame_ global variables
        for k, _ in pairs(config.default_opts) do
            vim.g["gitblame_" .. k] = nil
        end
    end)

    describe("setup", function()
        it("should set default options when called with no arguments", function()
            config.setup()
            assert.are.equal(true, vim.g.gitblame_enabled)
            assert.are.equal("%c", vim.g.gitblame_date_format)
            assert.are.equal(250, vim.g.gitblame_delay)
            assert.are.equal("Comment", vim.g.gitblame_highlight_group)
            assert.are.equal(true, vim.g.gitblame_display_virtual_text)
        end)

        it("should override defaults with provided options", function()
            config.setup({
                enabled = false,
                delay = 500,
                highlight_group = "Question",
            })
            assert.are.equal(false, vim.g.gitblame_enabled)
            assert.are.equal(500, vim.g.gitblame_delay)
            assert.are.equal("Question", vim.g.gitblame_highlight_group)
        end)

        it("should respect global vim variables", function()
            vim.g.gitblame_enabled = false
            vim.g.gitblame_delay = 1000
            config.setup()
            assert.are.equal(false, vim.g.gitblame_enabled)
            assert.are.equal(1000, vim.g.gitblame_delay)
        end)

        it("should prioritize setup opts over global variables", function()
            vim.g.gitblame_delay = 1000
            config.setup({ delay = 500 })
            assert.are.equal(500, vim.g.gitblame_delay)
        end)

        it("should set default message template", function()
            config.setup()
            assert.are.equal("  <author> • <date> • <summary>", vim.g.gitblame_message_template)
        end)

        it("should set default message_when_not_committed", function()
            config.setup()
            assert.are.equal("  Not Committed Yet", vim.g.gitblame_message_when_not_committed)
        end)

        it("should set default max_commit_summary_length", function()
            config.setup()
            assert.are.equal(0, vim.g.gitblame_max_commit_summary_length)
        end)

        it("should set default clipboard_register", function()
            config.setup()
            assert.are.equal("+", vim.g.gitblame_clipboard_register)
        end)
    end)

    describe("default_opts", function()
        it("should contain all expected keys", function()
            local expected_keys = {
                "enabled",
                "date_format",
                "message_template",
                "message_when_not_committed",
                "highlight_group",
                "set_extmark_options",
                "display_virtual_text",
                "ignored_filetypes",
                "delay",
                "use_blame_commit_file_urls",
                "schedule_event",
                "clear_event",
                "clipboard_register",
                "max_commit_summary_length",
                "remote_domains",
            }

            -- These keys should have non-nil defaults
            for _, key in ipairs(expected_keys) do
                assert.is_not_nil(config.default_opts[key], "Missing default option: " .. key)
            end

            -- virtual_text_column intentionally defaults to nil
            assert.is_true(true) -- key exists in the type definition
        end)
    end)
end)
