return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true, indent = { char = "┊" } },
    dashboard = {
      enabled = true,
      preset = {
        header = (function()
            local hour = tonumber(os.date("%H"))
            if hour >= 10 and hour < 18 then
                return require("utils.header").jollyroger
            else
                return require("utils.header").zoro
            end
        end)()
      }
    },
    picker = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = true },
		scope = { enabled = true },
	},
	keys = {
		-- Lazygit
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", }, -- Notiifcations
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
		{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History", },
    -- Search
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		-- References
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
        -- wrap text
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        -- dim mode
				Snacks.toggle.dim():map("<leader>dim")
			end,
		})
	end,
}
