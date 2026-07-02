-- Claude Code <-> nvim integration (ported from the previous LazyVim setup).
-- NvChad does not ship snacks.nvim (LazyVim does), so it is declared as an
-- explicit dependency here because the terminal provider is "snacks".
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    diff_opts = {
      layout = "vertical",
      keep_terminal_focus = false,
      open_in_current_tab = true,
    },
    terminal = {
      provider = "snacks",
      split_side = "right",
      split_width_percentage = 0.30,
      snacks_win_opts = {
        position = "bottom",
        height = 0.40,
      },
    },
  },
  init = function()
    vim.keymap.set({ "n", "t", "i" }, "<C-,>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
    vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
    vim.keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.schedule(function()
          pcall(vim.keymap.del, "n", "<leader>cc", { buffer = args.buf })
          vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { buffer = args.buf, desc = "Toggle Claude" })
        end)
      end,
    })
    local grp = vim.api.nvim_create_augroup("ClaudecodeDiffUX", { clear = true })
    vim.api.nvim_create_autocmd("OptionSet", {
      group = grp,
      pattern = "diff",
      callback = function()
        if vim.v.option_new == "1" or vim.v.option_new == true then
          vim.wo.wrap = false
          vim.wo.linebreak = false
        end
      end,
    })
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      group = grp,
      callback = function()
        if vim.wo.diff then
          vim.wo.wrap = false
        end
      end,
    })
    vim.o.autoread = true
    vim.api.nvim_create_autocmd({ "BufWipeout", "BufUnload" }, {
      group = grp,
      callback = function(args)
        local pname = vim.api.nvim_buf_get_name(args.buf)
        local m = pname:match("^(.-)%s*%(proposed%)%s*$")
        vim.schedule(function()
          pcall(vim.cmd, "checktime")
          if m and #m > 0 then
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(b) and vim.api.nvim_buf_is_loaded(b) then
                local bname = vim.api.nvim_buf_get_name(b)
                if bname ~= "" and (bname == m or vim.fn.fnamemodify(bname, ":t") == vim.fn.fnamemodify(m, ":t")) then
                  vim.api.nvim_buf_call(b, function() pcall(vim.cmd, "edit!") end)
                end
              end
            end
          end
        end)
      end,
    })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
      group = grp,
      callback = function() pcall(vim.cmd, "checktime") end,
    })
  end,
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
  keys = {
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>cA", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>cD", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
  },
}
