-- Minimal init.lua for running tests
-- This file is used by the test runner to set up a minimal Neovim environment.

-- Add the plugin to the runtime path
vim.opt.rtp:append(".")

-- Add plenary.nvim to the runtime path (cloned into deps/ by CI or user)
vim.opt.rtp:append("deps/plenary.nvim")

-- Disable swap files for tests
vim.opt.swapfile = false

-- Set up plenary if available
local ok, _ = pcall(require, "plenary")
if not ok then
    print("plenary.nvim is required for running tests")
    print("Install it to: ./deps/plenary.nvim")
    vim.cmd("cquit 1")
end
