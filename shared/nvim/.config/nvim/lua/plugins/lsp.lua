return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      gdscript = {
        mason = false
      },
      ols = {
        on_attach = function(client)
          client.server_capabilities.completionProvider = nil
        end,
      },
    }
  }
}
