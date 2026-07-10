return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default", -- keep default keymaps or use "none"
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "cancel", "fallback" },
    },
  },
}
