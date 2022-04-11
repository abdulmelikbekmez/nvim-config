local status, luasnip = pcall(require, "luasnip")
if not status then
	return
end

local types = require("luasnip.util.types")

luasnip.config.setup({
	-- ext_opts = {
	-- 	[types.choiceNode] = {
	-- 		active = {
	-- 			virt_text = { { "●", "GruvboxOrange" } },
	-- 		},
	-- 	},
	-- 	[types.insertNode] = {
	-- 		active = {
	-- 			virt_text = { { "●", "GruvboxBlue" } },
	-- 		},
	-- 	},
	-- },
})
