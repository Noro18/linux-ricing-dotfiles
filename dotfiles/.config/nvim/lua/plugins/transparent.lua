return {
  -- Optional: use the transparent.nvim plugin (easiest method)
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "TelescopeNormal",
        "TelescopeBorder",
        "LazyNormal",
        "MasonNormal",
      },
    },
  },
}
