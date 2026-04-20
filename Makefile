.PHONY: test lint format

# Run tests with plenary.nvim test harness
test:
	@nvim --headless --noplugin \
		-u tests/minimal_init.lua \
		-c "lua require('plenary.test_harness').test_directory('tests/', {minimal_init = 'tests/minimal_init.lua'})"

# Run luacheck linting
lint:
	luacheck lua/ plugin/

# Run stylua formatting check
format-check:
	stylua --check .

# Run stylua formatting
format:
	stylua .
