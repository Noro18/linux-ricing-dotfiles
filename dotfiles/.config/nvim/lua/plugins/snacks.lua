return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = true,

        follow_file = true,

        replace_netrw = true,

        auto_close = false,

        focus = "list",

        win = {
          list = {
            keys = {
              ["l"] = "confirm",
              ["h"] = "close_node",
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["y"] = "explorer_yank",
              ["p"] = "explorer_paste",
            },
          },
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      root = {
        autocmd = false,
      },
    },
  },
}
