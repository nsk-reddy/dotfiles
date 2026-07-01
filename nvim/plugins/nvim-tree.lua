-- NvChad ships nvim-tree as its file explorer and configures it via
--   opts = function() return require "nvchad.configs.nvimtree" end
-- which ignores any merged-in opts, so an opts override gets clobbered.
-- Instead we take over `config`: start from NvChad's own config table,
-- move the tree to the RIGHT and reveal dotfiles + gitignored files,
-- then run setup ourselves. (last `config` wins; NvChad only sets opts.)
return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local opts = require "nvchad.configs.nvimtree"

    opts.view = opts.view or {}
    opts.view.side = "right"
    opts.view.width = 32

    opts.filters = opts.filters or {}
    opts.filters.dotfiles = false      -- show .env, .gitignore, etc.
    opts.filters.git_ignored = false   -- show gitignored files too

    require("nvim-tree").setup(opts)
  end,
}
