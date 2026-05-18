return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {
      use_palette = "wallust",
    },
    config = function(_, opts)
      require("neopywal").setup(opts)
      vim.cmd.colorscheme("neopywal")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "neopywal"
    end,
  },
}
