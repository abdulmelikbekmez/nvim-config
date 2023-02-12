return {
    {
        "rcarriga/nvim-notify",
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
        opts = function()
            return {
                background_colour = "Normal",
                fps = 30,
                icons = {
                    DEBUG = "",
                    ERROR = "",
                    INFO = "",
                    TRACE = "✎",
                    WARN = ""
                },
                level = 2,
                minimum_width = 50,
                render = "compact",
                stages = "fade_in_slide_out",
                timeout = 3000,
                top_down = true
            }
        end
    }
}
