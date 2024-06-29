
require('lualine').setup({
    options = {
        section_separators = '',
        component_separators = '|',
        icons_enabled = false,
        theme = 'auto'
        
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },

        -- right
        lualine_x = { 'g:zoom#statustext', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    extensions = { 'quickfix', 'fugitive', 'fzf' },
})
--
--    opts = {
--      options = {
--        icons_enabled = false,
--        theme = 'nord',
--        component_separators = '|',
--        section_separators = '',
--      },
--    },
