# rake.nvim

A lightweight Neovim plugin that provides a floating dialog for setting the `makeprg`.

## Features

- Floating dialog to edit `makeprg` without leaving the editor
- Supports both global and buffer-local `makeprg` settings
- Pre-fills with current value for quick editing

## Usage

| Command       | Description                      |
|---------------|----------------------------------|
| `:Rake`       | Set global `makeprg`             |
| `:Rake local` | Set buffer-local `makeprg`       |

**Dialog keybindings:**
- `<CR>` - Confirm and apply
- `<Esc>` - Cancel

### Suggested Keymaps

```lua
vim.keymap.set("n", "<leader>mr", "<cmd>Rake<cr>", { desc = "Set makeprg" })
vim.keymap.set("n", "<leader>ml", "<cmd>Rake local<cr>", { desc = "Set makeprg (local)" })
```

## License

MIT
