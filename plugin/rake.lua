vim.api.nvim_create_user_command("Rake", function(opts)
  local use_local = opts.args == "local"
  require("rake").open_makeprg_dialog({ use_local = use_local })
end, {
  desc = "Open dialog to set makeprg",
  nargs = "?",
  complete = function()
    return { "local" }
  end,
})
