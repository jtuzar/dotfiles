return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {},
    picker = {
      sources = {
        explorer = {
          hidden = true,
          grep = { hidden = true },
          files = { hidden = true },
        },
      },
    },
    scroll = {
      enabled = false,
    },
    dashboard = {
      preset = {
        header = {
          [[
    ███        ▄█    █▄     ▄█  ███▄▄▄▄      ▄█   ▄█▄
▀█████████▄   ███    ███   ███  ███▀▀▀██▄   ███ ▄███▀
   ▀███▀▀██   ███    ███   ███▌ ███   ███   ███▐██▀
    ███   ▀  ▄███▄▄▄▄███▄▄ ███▌ ███   ███  ▄█████▀
    ███     ▀▀███▀▀▀▀███▀  ███▌ ███   ███ ▀▀█████▄
    ███       ███    ███   ███  ███   ███   ███▐██▄
    ███       ███    ███   ███  ███   ███   ███ ▀███▄
   ▄████▀     ███    █▀    █▀    ▀█   █▀    ███   ▀█▀
                                            ▀]],
          width = 53,
          align = "left",
        },
      },
      sections = {
        { section = "header", align = "center" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    }
  },
  keys = {
    { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer" },
  }
}
