local ok_notify, notify = pcall(require, "notify")
if not ok_notify then
    return
end

vim.notify = notify
notify.setup({
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
})
