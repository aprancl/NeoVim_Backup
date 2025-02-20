local M = {}

-- Read Kitty theme file and extract colors
local function read_kitty_theme()
    local kitty_theme_path = os.getenv("HOME") .. "/.config/kitty/current-theme.conf"
    local colors = {}

    local file = io.open(kitty_theme_path, "r")
    if not file then
        vim.api.nvim_err_writeln("Failed to open Kitty theme file: " .. kitty_theme_path)
        return nil
    end

    for line in file:lines() do
        local key, value = line:match("^(%S+)%s+(#%x+)")
        if key and value then
            colors[key] = value
        end
    end

    file:close()
    return colors
end

-- Apply colors to Neovim
function M.apply_theme()
    local colors = read_kitty_theme()
    if not colors then
        return
    end

    -- Set basic UI colors
    vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
    vim.api.nvim_set_hl(0, "Cursor", { fg = colors.cursor_text_color, bg = colors.cursor })
    vim.api.nvim_set_hl(0, "Visual", { fg = colors.selection_foreground, bg = colors.selection_background })
    
    -- Ensure Syntax Highlighting is applied (Standard)
    vim.api.nvim_set_hl(0, "Comment", { fg = colors.color8, italic = true })
    vim.api.nvim_set_hl(0, "String", { fg = colors.color2 })
    vim.api.nvim_set_hl(0, "Keyword", { fg = colors.color4, bold = true }) -- Traditional keywords
    vim.api.nvim_set_hl(0, "Function", { fg = colors.color5 })
    vim.api.nvim_set_hl(0, "Type", { fg = colors.color6, bold = true })
    vim.api.nvim_set_hl(0, "Constant", { fg = colors.color3 })
    vim.api.nvim_set_hl(0, "Variable", { fg = colors.foreground })
    vim.api.nvim_set_hl(0, "Operator", { fg = colors.color4 })
    
    -- Diagnostics & UI Elements
    vim.api.nvim_set_hl(0, "Error", { fg = colors.color1, bold = true })
    vim.api.nvim_set_hl(0, "Warning", { fg = colors.color3 })
    vim.api.nvim_set_hl(0, "Info", { fg = colors.color6 })
    vim.api.nvim_set_hl(0, "Hint", { fg = colors.color7 })

    -- Set terminal colors
    for i = 0, 15 do
        local key = "color" .. i
        if colors[key] then
            vim.api.nvim_set_hl(0, "TermColor" .. i, { fg = colors[key] })
        end
    end

    -- Treesitter Highlighting
    vim.api.nvim_set_hl(0, "@keyword", { fg = colors.color4, bold = true })      -- Fixes "not", "and", "or"
    vim.api.nvim_set_hl(0, "@keyword.operator", { fg = colors.color4, bold = true }) -- Logical operators
    vim.api.nvim_set_hl(0, "@function", { fg = colors.color5 })                  -- Function names
    vim.api.nvim_set_hl(0, "@function.call", { fg = colors.color5 })             -- Function calls
    vim.api.nvim_set_hl(0, "@variable", { fg = colors.foreground })              -- Normal variables
    vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.color3 })          -- Built-in variables (e.g., 'vim.api')
    vim.api.nvim_set_hl(0, "@field", { fg = colors.color6 })                      -- Object fields (e.g., `vim.api.somefunc`)
    vim.api.nvim_set_hl(0, "@type", { fg = colors.color6, bold = true })         -- Types (e.g., `integer`, `string`)
    vim.api.nvim_set_hl(0, "@constant", { fg = colors.color3 })                  -- Constants
    vim.api.nvim_set_hl(0, "@operator", { fg = colors.color4 })                  -- Operators
    vim.api.nvim_set_hl(0, "@comment", { fg = colors.color8, italic = true })    -- Comments
    vim.api.nvim_set_hl(0, "@punctuation", { fg = colors.foreground })           -- Punctuation (like commas, dots)
    vim.api.nvim_set_hl(0, "@namespace", { fg = colors.color6 })                 -- Namespaces (`vim.api`)
    vim.api.nvim_set_hl(0, "@property", { fg = colors.color7 })                  -- Object properties
    vim.api.nvim_set_hl(0, "@string", { fg = colors.color2 })                    -- Strings
    vim.api.nvim_set_hl(0, "@number", { fg = colors.color3 })                    -- Numbers

    -- Register the colorscheme
    vim.g.colors_name = "kittysynctheme"
end

-- Register the colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "kittysynctheme",
    callback = M.apply_theme,
})

return M
