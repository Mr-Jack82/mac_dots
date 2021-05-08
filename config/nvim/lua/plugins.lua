return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim"}

        -- LSP, Autocomplete and snippets
        use {
            "neovim/nvim-lspconfig",
            "glepnir/lspsaga.nvim",
            "hrsh7th/nvim-compe",
            "sbdchd/neoformat",
            "hrsh7th/vim-vsnip",
            "kabouzeid/nvim-lspinstall",
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzy-native.nvim"}
            }
        }

        -- Treesitter
        use {
            {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
            "p00f/nvim-ts-rainbow"
        }

        -- Git
        use "lewis6991/gitsigns.nvim"

        -- File manager
        use "kyazdani42/nvim-tree.lua"

        -- Markdown
        use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

        -- Statusline
        use "famiu/feline.nvim"

        -- Terminal
        use "akinsho/nvim-toggleterm.lua"

        -- General plugins
        use {
            "mbbill/undotree",
            "mhinz/vim-startify",
            "b3nj5m1n/kommentary",
            "folke/which-key.nvim",
            "windwp/nvim-autopairs",
            "norcalli/nvim-colorizer.lua",
            "blackCauldron7/surround.nvim",
            "kyazdani42/nvim-web-devicons",
            {"turbio/bracey.vim", run = "npm install --prefix server"},
            "junegunn/vim-easy-align",
            "editorconfig/editorconfig-vim",
            "tpope/vim-unimpaired",
            {"lukas-reineke/indent-blankline.nvim", branch = "lua"},
            "tpope/vim-surround",
            "tpope/vim-repeat",

            -- TODO: I need to choose one
            "easymotion/vim-easymotion",
            -- "phaazon/hop.nvim",

            "907th/vim-auto-save",
            {
              "andymass/vim-matchup",
              ft = {'html', 'javascript', 'json', 'xml'}
            }
        }

        -- Themes
        use {
            "rakr/vim-one",
            "rafamadriz/neon",
            "morhetz/gruvbox",
            {"dracula/vim", as = "dracula"},
            "christianchiarulli/nvcode-color-schemes.vim",
            {"npxbr/gruvbox.nvim", requires = "rktjmp/lush.nvim"}
        }
    end
)
