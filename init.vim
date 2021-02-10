" Configure Python
let g:python_host_prog  = $HOME . "/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python3"

" disable syntax helpers until other resources are loaded.
syntax off
filetype plugin indent off


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
Plug 'fatih/vim-go'
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
Plug 'tpope/vim-commentary'
Plug 'OmniSharp/omnisharp-vim'
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
autocmd Syntax vim if exists("b:current_syntax") | call SyntaxRange#Include('<<LUA', 'LUA', 'lua')

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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Enable Colorcolumn at Line 80
set colorcolumn=80

colors ir_black
silent! colors grb256

set inccommand=nosplit

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

"Folding
set foldopen=hor,mark,percent,quickfix,search,tag,undo


lua <<LUA
-- vim.lsp.set_log_level("debug")
require'lspconfig'.ghcide.setup{}     -- Haskell
require'lspconfig'.vimls.setup{}      -- vimscript
require'lspconfig'.pyls.setup{}       -- Python
require'lspconfig'.terraformls.setup{ -- Terraform
  cmd = { "terraform-ls", "serve",
          "-log-file=/tmp/terraform-ls-{{pid}}.log",
	        "-tf-log-file=/tmp/tf-exec-{{lsPid}}-{{args}}.log",
        };
}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.omnisharp.setup{}
LUA

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>


nnoremap q: <nop>
