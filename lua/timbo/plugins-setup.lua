-- -- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- install preffered colourscheme
  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
 
  -- install Material colourscheme
  use ("marko-cerovac/material.nvim")
  
  -- install Nord Vim colourscheme
  use("arcticicestudio/nord-vim")
  
  -- install NightFox colourscheme
  use ("EdenEast/nightfox.nvim")

  -- Mason plugin
  use ("williamboman/mason.nvim")    
  use ("williamboman/mason-lspconfig.nvim")
  
  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
 
  use("szw/vim-maximizer") -- maximizes and restores current window 
  
  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")
  use { "nvim-treesitter/nvim-treesitter" }
  -- floating terminal
  use("voldikss/vim-floaterm")

   -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")

  -- status line
  use("nvim-lualine/lualine.nvim")

  -- telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

  -- Install Rust related plugins
  use { "neovim/nvim-lspconfig" }
  use { "simrat39/rust-tools.nvim" }

  -- Completion framework:
  use { "hrsh7th/nvim-cmp" } 

  -- LSP completion source:
  use { "hrsh7th/cmp-nvim-lsp" }

  -- Useful completion sources:
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-nvim-lsp-signature-help" }
  use { "hrsh7th/cmp-vsnip" }                             
  use { "hrsh7th/cmp-path" }                              
  use { "hrsh7th/cmp-buffer" }                            
  use { "hrsh7th/vim-vsnip" } 
  
  -- Plugin for closing brackets
  use { "windwp/nvim-autopairs" }

  -- Debugging
  use { "nvim-lua/plenary.nvim" }
  use { "mfussenegger/nvim-dap" }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
