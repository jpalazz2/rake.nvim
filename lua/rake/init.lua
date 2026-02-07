local M = {}

function M.open_makeprg_dialog(opts)
  opts = opts or {}
  local use_local = opts.use_local or false
  local source_buf = vim.api.nvim_get_current_buf()

  local buf = vim.api.nvim_create_buf(false, true)

  local width = 50
  local height = 1

  local ui = vim.api.nvim_list_uis()[1]
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local title = use_local and " Set makeprg (local) " or " Set makeprg "
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  })

  -- Pre-fill with current makeprg value (prefer local if it exists)
  local current = use_local and vim.bo[source_buf].makeprg or vim.o.makeprg
  if current and current ~= "" then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { current })
  end

  -- Start in insert mode
  vim.cmd("startinsert!")

  -- Set up Enter to confirm and close
  vim.keymap.set("i", "<CR>", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local value = lines[1] or ""
    vim.api.nvim_win_close(win, true)
    vim.cmd("stopinsert")
    if use_local then
      vim.bo[source_buf].makeprg = value
      vim.notify("makeprg (local) set to: " .. value)
    else
      vim.o.makeprg = value
      vim.notify("makeprg set to: " .. value)
    end
  end, { buffer = buf, noremap = true })

  -- Set up Escape to cancel
  vim.keymap.set({ "i", "n" }, "<Esc>", function()
    vim.api.nvim_win_close(win, true)
    vim.cmd("stopinsert")
  end, { buffer = buf, noremap = true })
end

function M.setup(opts)
  -- Setup function for future configuration options
end

return M
