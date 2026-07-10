return {
  -- Target the existing vimtex package pulled by the extra
  "lervag/vimtex",
  lazy = false, -- Never lazy load vimtex
  init = function()
    -- Set Zathura as your viewer on Arch Linux
    vim.g.vimtex_view_method = "zathura"

    -- Optional: Automatically pop out the Zathura screen upon compilation trigger
    vim.g.vimtex_view_automatic = 1
  end,
}
