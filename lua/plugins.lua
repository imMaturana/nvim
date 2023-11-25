local o = vim.o
local cmd = vim.cmd
local keymap = vim.keymap

return {
    -- ui
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    icons_enabled = true,
                },
            })
        end,
    },
    
    -- themes
    {
	    "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
            })

            o.termguicolors = true

            cmd([[ colorscheme catppuccin ]])
        end
    },
    "kyazdani42/nvim-web-devicons",

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope_builtin = require("telescope.builtin")

            keymap.set("n", "<leader>ff", telescope_builtin.find_files)
        end,
    },

    -- programming languages
    "fatih/vim-go",
    "mattn/emmet-vim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- lsp and completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspconfig = require("lspconfig")
            local lspkind = require("lspkind")

            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }),

                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",

                        menu = {
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        },

                        after = function(entry, vim_item, kind)
                            local strings = vim.split(kind.kind, "%s", { trimempty = true })
                            kind.kind = " " .. strings[1] .. " "
                            kind.menu = "   " .. strings[2]
                            return kind
                        end,
                    }),
                },
            })

            local servers = {
                "gopls",
                "rust_analyzer",
                "pyright",
                "zls",
                "tsserver",
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, server in ipairs(servers) do
                lspconfig[server].setup({ capabilities })
            end
        end,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }
}
