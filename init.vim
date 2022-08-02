" disable syntax helpers until other resources are loaded.
syntax off
filetype plugin indent off


" Force the use of specific python venv
" TODO: We should be able to handle this in a more graceful way for
"       a cross-platform config
let g:python3_host_prog = '/Users/brian.shacklett/.pyenv/shims/python3'


" Ensure plug.vim is installed
let s:plugscript = join([
                          \fnamemodify($MYVIMRC, ":p:h"),
                          \'autoload',
                          \'plug.vim',
                        \], '/')
let s:plugsource = join([
                          \'https://raw.githubusercontent.com',
                          \'junegunn',
                          \'vim-plug',
                          \'master',
                          \'plug.vim',
                        \], '/')
if empty(glob(s:plugscript))
  execute join([
                 \'!curl -fLo',
                 \s:plugscript,
                 \'--create-dirs ',
                 \s:plugsource,
               \], ' ')
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Configure plugins
call plug#begin()
Plug 'bkad/CamelCaseMotion'
Plug 'PProvost/vim-ps1'
Plug 'gregsexton/MatchTag'
Plug 'rodjek/vim-puppet'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'elzr/vim-json'
Plug 'shime/vim-livedown'
Plug 'bgshacklett/aws-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'OrangeT/vim-csharp'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'bgshacklett/vitality.vim'
Plug 'hashivim/vim-terraform'
Plug 'epcim/vim-chef'
Plug 'hashivim/vim-vagrant'
Plug 'hashivim/vim-packer'
Plug 'vim-scripts/SyntaxRange'
Plug 'vito-c/jq.vim'
Plug 'vim-vdebug/vdebug'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/deoplete.nvim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'towolf/vim-helm'
Plug 'vim-ruby/vim-ruby'
Plug 'neovim/nvim-lspconfig'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-commentary'
Plug 'OmniSharp/omnisharp-vim'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'Rykka/InstantRst'
Plug 'kyazdani42/nvim-web-devicons' " Dependency of trouble.nvim
Plug 'folke/trouble.nvim'
Plug 'rakr/vim-one'
Plug 'vim-python/python-syntax'
" Plug '~/Projects/nvim-lspconfig' " Development Repo
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wfaulk/iRuler.vim'
call plug#end()



" Mac specific configs
if has('mac')
  " Configure automatic cursor shape for Insert and Normal Modes
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"

  " Set the shell to `sh` for posix compatibility
  set shell=sh
endif

" Configure Leader
let mapleader = ","

" Re-enable and configure syntax helpers.
syntax on
autocmd Syntax terraform if exists("b:current_syntax") | call SyntaxRange#Include('<<JSON', 'JSON', 'json')
autocmd Syntax terraform if exists("b:current_syntax") | call SyntaxRange#Include("'''#!/bin/sh", "'''", 'sh')
autocmd Syntax vim if exists("b:current_syntax") | call SyntaxRange#Include('<<LUA', 'LUA', 'lua')


" Syntax Highlighting
let g:python_highlight_all = 1

" Configure indentation
filetype plugin indent on
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Configure Folding
nnoremap <Space> za
vnoremap <Space> za

" Configure Encoding
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif"

" General Preferences
set hlsearch
set ruler
set laststatus=2 " Always enable status bar
set number
set wrap! " Don't wrap long lines

" If running inside of ConEmu, 256-color support is available.
if $ConEmuPID
    set t_Co=256
endif

" Set up 256 color mode.
if &t_Co > 16
  set termguicolors
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>

" Enable, and configure hidden chars
set list
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:␣,trail:•

" Enable Colorcolumn at Line 80
set colorcolumn=80

colors one
set background=dark
let g:airline_theme='one'

set inccommand=nosplit

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

"Folding
set foldopen=hor,mark,percent,quickfix,search,tag,undo

augroup AutoSaveFolds
  autocmd!
  " autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END


lua <<LUA
HOME = os.getenv("HOME")
XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or HOME .. "/.config"
XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME") or HOME .. "/.cache"
XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or HOME .. "/.local/share"
BIN_HOME = HOME .. "/.local/bin"

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader><space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader><space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader><space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

-- vim.lsp.set_log_level("debug")
require'lspconfig'.bashls.setup{}  -- Bash
require'lspconfig'.hls.setup{      -- Haskell
  on_attach = on_attach,
  cmd = { 'stack', 'exec', 'haskell-language-server-wrapper', '--', '--lsp' },
}
require'lspconfig'.vimls.setup{}   -- vimscript
require'lspconfig'.pyright.setup{  -- Python
    on_attach = on_attach,
}
require'lspconfig'.gopls.setup{    -- Go
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}
require'lspconfig'.terraformls.setup{ -- Terraform
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "terraform-ls", "serve",
          "-log-file=/tmp/terraform-ls.log",
          "-tf-log-file=/tmp/tf-exec.log",
        };
}
require'lspconfig'.solargraph.setup{  -- Ruby
  cmd = { "bundle", "exec", "solargraph", "stdio" };
  on_attach = on_attach,
}
require'lspconfig'.yamlls.setup{
  on_attach = on_attach,
}
-- require'lspconfig'.omnisharp.setup{}
require'lspconfig'.efm.setup{         -- General Purpose Lang Server
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    init_options = {documentFormatting = true},
    filetypes = {
      "sh",
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            sh = {
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck',
                    lintFormats= {
                        '%f:%l:%c: %trror: %m',
                        '%f:%l:%c: %tarning: %m',
                        '%f:%l:%c: %tote: %m',
                    },
                }
            }
        }
    }
}
require'lspconfig'.groovyls.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "java", "-jar", BIN_HOME .. "/groovy-language-server-all.jar" },
  root_dir = function(fname)
    return vim.fn.getcwd()  -- TODO: handle more cases
  end,
  filetypes = { "groovy", "Jenkinsfile" },
  settings = {
    groovy = {
      classpath = {
        XDG_DATA_HOME .. "/groovy",
        XDG_DATA_HOME .. "/java",
        'build/**',
        'build/**/*.hpi',
        'build/classes/groovy/test',
        'build/classes/java/test',
      }
    }
  }
}

require("trouble").setup {
  -- your configuration comes here
  -- see https://github.com/folke/trouble.nvim for details
}


-- Mappings.
local opts = { noremap=true, silent=true }

LUA

" Populate locallist with lsp diagnostics automatically
:lua vim.diagnostic.setloclist({open = false})
autocmd User LspDiagnosticsChanged :lua vim.diagnostic.setloclist({open = false})
autocmd BufWritePre * :%s/\s\+$//e

nnoremap q: <nop>
