require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- test comment after github outage

    -- manage mason
    use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate" -- update registry stuff
    }

    -- manage nvim-treesitter
    use {
      "nvim-treesitter/nvim-treesitter"
    }

    -- manage alpha-nvim (splash screen)
    use {
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
    }

    -- manage language server config
    use 'neovim/nvim-lspconfig'

    -- manage vim-gitgutter
    use 'airblade/vim-gitgutter'

    -- manage completion engine - nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',  -- Required for snippet support
      }}

    -- manage vim-visual-multi
    use 'mg979/vim-visual-multi'

    -- manage nvim-tree
    use 'nvim-tree/nvim-tree.lua'
    vim.keymap.set('n', '©', ':NvimTreeOpen<CR>', { noremap = true, silent = true })

    vim.opt.number = true          -- Show line numbers
    vim.opt.tabstop = 2            -- Number of spaces a tab character occupies
    vim.opt.shiftwidth = 2         -- Number of spaces for each level of indentation
    vim.opt.expandtab = true       -- Use spaces instead of tabs
    
end)


require("mason").setup()

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- configuring LSP server 
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

require("nvim-tree").setup()

require("nvim-web-devicons").setup {
  default = true;
}

require('packer').startup(function()
  use 'navarasu/onedark.nvim'
end)

require('onedark').setup {
  style = 'dark', -- Options: dark, darker, cool, deep, warm, warmer
  transparent = true,
}

require('onedark').load()

require('nvim-treesitter.configs').setup {
  ensure_installed = {"c"}, -- Add more languages if needed
  highlight = { enable = true },
}
