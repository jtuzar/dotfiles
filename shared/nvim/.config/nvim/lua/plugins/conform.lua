return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      odinfmt = {
        command = "odinfmt",
        args = { "-stdin" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      cmake = { "gersemi" },
      gdscript = { "gdformat" },
      odin = { "odinfmt" },
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      },
    },
  },
}
