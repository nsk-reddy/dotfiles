return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
      width = 32,
    },
    filesystem = {
      filtered_items = {
        visible = true,        -- show filtered (hidden) items by default
        hide_dotfiles = false, -- show .env, .gitignore, etc.
        hide_gitignored = false,
      },
    },
  },
}
