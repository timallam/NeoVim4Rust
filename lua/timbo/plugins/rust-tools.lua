local ok, rt = pcall(require, "rust-tools")
if not ok then
  print("Rust-tools not found!!!")
  return
end

local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  
  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition,       keymap_opts)
  vim.keymap.set("n", "K",     vim.lsp.buf.hover,            keymap_opts)
  vim.keymap.set("n", "<C-g",  vim.lsp.buf.implementation,   keymap_opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,   keymap_opts)
  vim.keymap.set("n", "<C-7g", vim.lsp.buf.type_definition,  keymap_opts)
  vim.keymap.set("n", "gr",    vim.lsp.buf.references,       keymap_opts)
  vim.keymap.set("n", "g0",    vim.lsp.buf.document_symbol,  keymap_opts)
  vim.keymap.set("n", "gW",    vim.lsp.buf.workspace_symbol, keymap_opts)
  vim.keymap.set("n", "gd",    vim.lsp.buf.definition,       keymap_opts)
  vim.keymap.set("n", "ga",    vim.lsp.buf.code_action,      keymap_opts)
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
        -- https://github.com/simrat39/rust-tools.nvim/issues/300
        inlayHints = { 
          locationLinks = false,
        }
      },
    },
  },
}

rt.setup(opts)
