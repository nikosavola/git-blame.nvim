-- vim: ft=lua

std = "luajit+busted"

-- Neovim globals (allow read and write access to vim.g, vim.opt, etc.)
globals = {
    "vim",
}

-- Don't report unused self arguments of methods
self = false

-- Max line length
max_line_length = 120

-- Max code line length
max_code_line_length = 120

-- Allow max cyclomatic complexity (some parsers/formatters are inherently complex)
max_cyclomatic_complexity = 20

exclude_files = {
    ".luarocks/**",
    "deps/**",
}
