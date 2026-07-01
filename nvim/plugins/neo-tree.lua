-- LazyVim uses neo-tree as its file explorer. Move it to the RIGHT side
-- and show hidden dotfiles + gitignored files.
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
