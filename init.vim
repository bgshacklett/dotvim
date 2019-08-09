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
Plug 'dense-analysis/ale'
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
Plug 'chrisbra/csv.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'martinda/Jenkinsfile-vim-syntax'
call plug#end()


" Mac specific configs
if has('mac')
  " Configure automatic cursor shape for Insert and Normal Modes
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

" Configure Leader
let mapleader = ","

" Re-enable and configure syntax helpers.
syntax on
autocmd Syntax terraform if exists("b:current_syntax") | call SyntaxRange#Include('<<JSON', 'JSON', 'json', 'NonText')

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
