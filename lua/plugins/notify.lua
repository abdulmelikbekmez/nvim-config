return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
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
            timeout = 1000,
            top_down = true
        }
    end
}
