-- Make nvim's background transparent so the terminal's transparency
-- (wezterm background_opacity) shows through the editor, sidebars, and
-- floating windows. LazyVim defaults to tokyonight, which has a native
-- transparent mode; a ColorScheme autocmd clears a few extra groups and
-- keeps things transparent even if the colorscheme is switched.
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = function()
      local grp = vim.api.nvim_create_augroup("UserTransparency", { clear = true })
      local function clear()
        for _, g in ipairs({
          "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
          "SignColumn", "MsgArea", "NeoTreeNormal", "NeoTreeNormalNC",
          "NeoTreeEndOfBuffer", "TelescopeNormal", "TelescopeBorder",
          "WhichKeyFloat", "LazyNormal", "MiniFilesNormal",
        }) do
          pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
        end
      end
      vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = clear })
      clear() -- apply now for the already-loaded colorscheme
    end,
  },
}
