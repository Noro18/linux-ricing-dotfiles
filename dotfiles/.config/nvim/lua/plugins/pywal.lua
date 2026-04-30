return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {
      -- You can add Neopywal specific options here
      -- See :h neopywal-configuration
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
