-- Replace the default "LAZYVIM" dashboard header with the current project
-- (cwd basename) rendered in the ANSI_Shadow figlet font. So opening nvim
-- inside ~/VS/agent-agnes shows "agent-agnes", inside bonnie-ai shows
-- "bonnie-ai", etc. Falls back to the plain name if figlet is missing.
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    if name == "" then
      name = "nvim"
    end

    local header = name
    local ok, out = pcall(vim.fn.systemlist, { "figlet", "-f", "ANSI_Shadow", name })
    if ok and vim.v.shell_error == 0 and type(out) == "table" and #out > 0 then
      header = table.concat(out, "\n") .. "\n"
    end

    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.header = header
    return opts
  end,
}
