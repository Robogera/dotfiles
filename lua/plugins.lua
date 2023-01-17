-- Packer stuff
return require( 'packer' ).startup( function( use )

  -- Plugin manager
  use { 'wbthomason/packer.nvim' }

  -------------------------
  -- T R E E S I T T E R --
  -------------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 'c', 'lua', 'go', 'bash', 'yaml', 'html', 'json5', 'markdown', 'python', 'zig' },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    
    end,
  }
  ---------------------
  -- N V I M T R E E --
  ---------------------
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly',
    config = function()
      
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          adaptive_size = false,
          width = 25,
          side = "left"
        },
        renderer = {
          group_empty = true,
          highlight_opened_files = "all",
        },
        filters = {
          dotfiles = false,
        },
      })
    
    end,
  }

  -----------------------
  -- T E L E S C O P E --
  -----------------------
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  
  -------------------
  -- C O Q N V I M --
  -------------------
  use {
    'ms-jpq/coq_nvim',
    branch = "coq",
  }
--  use {
--    'ms-jpq/coq.artifacts',
--    branch = "artifacts"
--  }
--
  use {
    'airblade/vim-gitgutter',
--    config = function()
--      require("vim-gitgutter").setup()
--    end,
  }
  -------------------------
  -- L S P --
  -------------------------
  use {
    "neovim/nvim-lspconfig",
--    config = function()
--      require("nvim-lspconfig").setup()
--    end,
  }
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  -------------------------
  -- C A T P P U C C I N --
  -------------------------
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }

  -------------------
  -- L U A L I N E --
  -------------------
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()

      require("lualine").setup({
        
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = {
            left = "",
            right = "",
          },
          section_separators = {
            left = "",
            right = "",
          },
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },

        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"},
        }

      })

    end,
  }

  -----------------------
  -- A U T O P A I R S --
  -----------------------
  use {
    'jiangmiao/auto-pairs'
  }

  -----------------------------------
  -- I N D E N T B L A N K L I N E --
  -----------------------------------
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()

      require("bufferline").setup{
        options = {
          separator_style = "thick",
          offsets = {
            {
              filetype = "NvimTree",
              text = "FILE TREE",
              separator = true
            }
          }
        }
      }

    end,
  }

  -- Ansible synax highlight because TS doesn't handle it yet
  use {
    'pearofducks/ansible-vim'
  }


end )

