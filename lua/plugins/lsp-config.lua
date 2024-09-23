return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_intsalled = {
					"lua_ls",
					"ts_ls",
					"omnisharp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			local os = require("os")
			local omnisharpPath = os.getenv("OmniSharp")
			local pid = vim.fn.getpid()
			--local omnisharp_bin = "C:\\Users\\Alex Quennelle\\AppData\\Local\\bin\\omnisharp-roslyn\\Omnisharp.exe"
			lspconfig.omnisharp.setup({
				cmd = {
					--"OmniSharp",
					omnisharpPath,
					--"--languageserver",
					--"--hostPID",
					--tostring(pid),
					--"OmniSharp",
					--vim.fn.stdpath("data") .. "\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe",
					--"--languageserver FormattingOptions:OrganizeImports=true",
					--"--languageserver FormattingOptions:UseTabs=true"
				},
				settings = {
					FormattingOptions = {
						EnableEditorConfigSupport = false,
						OrganizeImports = true,
						UseTabs = true,
					},
				},
				capabilities = capabilities,
				enable_import_completion = true,
				--organize_imports_on_format = true,
				enable_roslyn_analuzers = true,
				root_dir = function()
					return vim.loop.cwd()
				end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {})
		end,
	},
}
--lspconfig.omnisharp.setup({})
