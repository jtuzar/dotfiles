return {
  "ThePrimeagen/harpoon",
  keys = function()
    local keys = {
      {
        "<C-A>",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File"
      },
      {
        "<C-S>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu"
      },
      {
        "<C-J>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon to File 1",
      },
      {
        "<C-K>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon to File 2",
      },
      {
        "<C-L>",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon to File 3",
      },
      {
        "<C-;>",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon to File 4",
      }
    }

    return keys
  end
}
