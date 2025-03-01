-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

table.insert(lvim.plugins, {
	"andweeb/presence.nvim",
	event = "VeryLazy",
	config = function()
		-- The setup config table shows all available config options with their default values:
		require("presence").setup({
			-- General options
			auto_update = true,        -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
			neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
			main_image = "neovim",     -- Main image display (either "neovim" or "file")
			log_level = nil,           -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
			debounce_timeout = 10,     -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
			enable_line_number = true, -- Displays the current line number instead of the current project
			blacklist = {},            -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
			buttons = true,            -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
			file_assets = {},          -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
			show_time = true,          -- Show the timer

			-- Rich Presence text options
			editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
			file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
			git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
			plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
			reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
			workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
			line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
		})
	end,
})

table.insert(lvim.plugins, {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	lazy = false,
	config = function()
		-- set keymaps
		local harpoon = require("harpoon")
		harpoon:setup()
		lvim.keys.normal_mode["<leader>ha"] = {
			function()
				harpoon:list():add()
			end,
			desc = "Add file to harpoon",
		}
		lvim.keys.normal_mode["<leader>hn"] = {
			function()
				harpoon:list():next()
			end,
			{ desc = "Go to next harpoon mark" },
		}

		lvim.keys.normal_mode["<leader>hp"] = {
			function()
				harpoon:list():prev()
			end,
			{ desc = "Go to previous harpoon mark" },
		}

		lvim.keys.normal_mode["<leader>hf"] = {
			function()
				harpoon:list():select(1)
			end,
			{ desc = "harpoon first" },
		}

		lvim.keys.normal_mode["<leader>hs"] = {
			function()
				harpoon:list():select(2)
			end,
			{ desc = "harpoon second" },
		}

		lvim.keys.normal_mode["<leader>ht"] = {
			function()
				harpoon:list():select(3)
			end,
			{ desc = "harpoon third" },
		}

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
			    .new({}, {
				    prompt_title = "Harpoon",
				    finder = require("telescope.finders").new_table({
					    results = file_paths,
				    }),
				    previewer = conf.file_previewer({}),
				    sorter = conf.generic_sorter({}),
			    })
			    :find()
		end

		lvim.keys.normal_mode["<leader>hm"] = {
			function()
				toggle_telescope(harpoon:list())
			end,
			desc = "open harpoon window",
		}
	end,
})

table.insert(
	lvim.plugins, -- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	}
)

table.insert(lvim.plugins, {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.surround").setup()
	end,
})

table.insert(lvim.plugins, {
	"ficcdaf/ashen.nvim",
	lazy = false,
	priority = 1000,
	opts = {
	},
})

table.insert(lvim.plugins, {
	"wnkz/monoglow.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
})

table.insert(lvim.plugins, {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals = require("metals")
		local metals_config = metals.bare_config()

		return metals_config
	end,

	config = function(_, _)
		local metals = require("metals")
		local metals_config = metals.bare_config()
		metals_config.settings = {
			showImplicitArguments = true,
		}
		metals_config.init_options.statusBarProvider = "on"
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
		local dap = require("dap")
		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "RunOrTest",
				metals = {
					runtType = "runOrTestFile",
				},
			},
			{
				type = "scala",
				request = "launch",
				name = "Test Target",
				metals = {
					runtType = "testTarget",
				},
			},
		}

		metals_config.on_attach = function(client, bufnr)
			metals.setup_dap()
		end

		vim.keymap.set("n", "<leader>lmc", function()
			require("telescope").extensions.metals.commands()
		end)

		local nvim_metals_group = api.nvim_create_augroup("metals", { clear = true })
		api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt", "java" },
			callback = function()
				metals.initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
})

-- keybinds
lvim.format_on_save.enabled = true

--visuals

lvim.transparent_window = true

lvim.colorscheme = "ashen"

vim.o.tabstop = 8
vim.o.shiftwidth = 8
vim.o.expandtab = false

vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })

-- commands

vim.api.nvim_create_augroup('navigation', { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = 'navigation',
	pattern = '*',
	command = 'set relativenumber number'
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = 'navigation',
	pattern = '*',
	command = "set clipboard=unnamedplus,unnamed",
})
