local M = {}

function M.setup()
	local cmp = require'cmp'
	local luasnip = require'luasnip'
	cmp.setup{
		sources = cmp.config.sources{
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'luasnip' },
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert{
			['<CR>'] = cmp.mapping.confirm{
				behavior = cmp.ConfirmBehavior.replace,
				select = true,
			},
			['<Tab>'] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {'i', 's'}),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable(-1) then
					luasnip.expand_or_jump(-1)
				else
					fallback()
				end
			end, {'i', 's'}),
		}
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	local mason_lspconfig = require'mason-lspconfig'
	mason_lspconfig.setup{
		ensure_installed = vim.tbl_keys({}),
	}
	mason_lspconfig.setup_handlers {
		function (server_name)
			require("lspconfig")[server_name].setup {}
		end,
		-- Next, you can provide a dedicated handler for specific servers.
		-- For example, a handler override for the `rust_analyzer`:
		-- ["rust_analyzer"] = function ()
		--     require("rust-tools").setup {}
		-- end
	}

	require'luasnip.loaders.from_lua'.load{
		paths = "~/.config/nvim/snippets/"
	}
	luasnip.config.set_config{
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true,
	}
end

return M
