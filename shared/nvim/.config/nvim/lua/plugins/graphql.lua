return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        graphql = {
          filetypes = {
            "graphql",
            "gql",
            "svelte",
            "typescript",
            "javascript",
            "typescriptreact",
            "javascriptreact",
          },
          single_file_support = false,
          settings = {
            ["graphql-config"] = {
              load = {
                fileName = "graphql.config.yml",
              },
            },
          },
          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = {
              "graphql-lsp",
              "server",
              "-m",
              "stream",
              "-c",
              new_root_dir,
            }
          end,
        },
      },
    },
  },
}
