local function set_dashboard_header_hl()
  local fg = "#7dcfff"

  if vim.g.colors_name and vim.g.colors_name:match("tokyonight") then
    local ok, tokyonight_colors = pcall(require, "tokyonight.colors")
    if ok then
      local c = tokyonight_colors.setup()
      fg = c.cyan or fg
    end
  end

  vim.api.nvim_set_hl(0, "SnacksDashboardHeaderCyan", { fg = fg, bg = "NONE" })
end

return {
  "folke/snacks.nvim",
  init = function()
    local group = vim.api.nvim_create_augroup("snacks_dashboard_header_palette", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      callback = set_dashboard_header_hl,
    })
    set_dashboard_header_hl()
  end,
  ---@type snacks.Config
  opts = {
    image = {},
    picker = {
      sources = {
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
        explorer = {
          hidden = true,
        },
      },
    },
    scroll = {
      enabled = false,
    },
    dashboard = {
      preset = {
        header = {
          { "    ███        ▄█    █▄     ▄█  ███▄▄▄▄      ▄█   ▄█▄", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "▀█████████▄   ███    ███   ███  ███▀▀▀██▄   ███ ▄███▀", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "   ▀███▀▀██   ███    ███   ███▌ ███   ███   ███▐██▀", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "    ███   ▀  ▄███▄▄▄▄███▄▄ ███▌ ███   ███  ▄█████▀", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "    ███     ▀▀███▀▀▀▀███▀  ███▌ ███   ███ ▀▀█████▄", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "    ███       ███    ███   ███  ███   ███   ███▐██▄", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "    ███       ███    ███   ███  ███   ███   ███ ▀███▄", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "   ▄████▀     ███    █▀    █▀    ▀█   █▀    ███   ▀█▀", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
          { "\n" },
          { "                                            ▀", hl = "SnacksDashboardHeaderCyan", width = 53, align = "left" },
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
