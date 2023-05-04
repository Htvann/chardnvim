dofile(vim.g.base46_cache .. "lsp")
local builtin = require "telescope.builtin"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  local optional = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gh", builtin.lsp_definitions, optional)        -- gd to go to definition
  vim.keymap.set("n", "K", vim.lsp.buf.hover, optional)               -- K to hover docs
  vim.keymap.set("n", "gr", "<Cmd> Lspsaga rename<CR>", optional)     -- gr to rename
  vim.keymap.set("n", "<C-i>", builtin.lsp_implementations, optional) -- gr to rename
  vim.keymap.set("n", "gi", "<Cmd> Lspsaga show_line_diagnostics<CR>", optional)
  vim.keymap.set("n", "F", builtin.lsp_document_symbols, optional)

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

return M
