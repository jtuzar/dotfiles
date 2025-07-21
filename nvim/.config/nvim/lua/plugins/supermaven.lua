return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({})
	end,
    keys = {
        {
            "<leader>ss",
            function ()
                local api = require("supermaven-nvim.api")
                api.start()
            end
        },
        {
            "<leader>st",
            function ()
                local api = require("supermaven-nvim.api")
                api.stop()
            end
        }
    }
}
