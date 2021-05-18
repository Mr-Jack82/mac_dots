return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim"}

        -- LSP, Autocomplete and snippets
        use {
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-compe",
            "hrsh7th/vim-vsnip",
            "kabouzeid/nvim-lspinstall",
            "rafamadriz/friendly-snippets"
        }
        -- ====================================

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzy-native.nvim"}
            }
        }
        -- ====================================

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        -- ====================================

        -- Utils
        use {
            "mbbill/undotree",
            "b3nj5m1n/kommentary",
            "folke/which-key.nvim",
            "machakann/vim-sandwich",
            "kyazdani42/nvim-tree.lua",
            "akinsho/nvim-toggleterm.lua"
        }
        -- ====================================

        -- General plugins
        use {
            "sbdchd/neoformat",
            "famiu/feline.nvim",
            "mhinz/vim-startify",
            "windwp/nvim-autopairs",
            "norcalli/nvim-colorizer.lua",
            "kyazdani42/nvim-web-devicons",
            {"turbio/bracey.vim", run = "npm install --prefix server"},
            {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"},
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
        -- ====================================

        -- Git
        use {"lewis6991/gitsigns.nvim", "tpope/vim-fugitive"}

        -- Themes
        use {
            "rafamadriz/neon",
            "rakr/vim-one",
            "tomasiser/vim-code-dark",
            "morhetz/gruvbox",
            {"dracula/vim", as = "dracula"},
            {"npxbr/gruvbox.nvim", requires = "rktjmp/lush.nvim"}
        }
    end
)
