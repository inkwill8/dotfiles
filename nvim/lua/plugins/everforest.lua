return {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme('everforest')
      vim.cmd("highlight CursorLine ctermbg=darkgrey guibg=#2a2a2a")
      vim.cmd("highlight CursorLineNr ctermfg=white guifg=white cterm=bold gui=bold")
    end
  }
