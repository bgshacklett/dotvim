" disable syntax helpers until other resources are loaded.
syntax off
filetype plugin indent off

" Fix Windows' path oddities.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

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

" Load Pathogen
source $HOME/.vim/bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = [""]
execute pathogen#infect()
Helptags

" Disable concealing double quotes in json files, because it's ridiculous
let g:vim_json_syntax_conceal = 0

" Enable CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Re-enable syntax helpers.
syntax on

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

" Airline Plugin
let g:airline_powerline_fonts = 1

" General Preferences
set hlsearch
set ruler
set laststatus=2 " Always enable status bar
set number

" If running inside of ConEmu, 256-color support is available.
if $ConEmuPID
    set t_Co=256
endif

" Set colorscheme for 256 color mode.
if &t_Co > 16
	colors grb256-custom
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>

" Enable, and configure hidden chars
set list
set listchars=tab:»\ ,eol:¬

" Enable Colorcolumn at Line 80
set colorcolumn=80

if has('gui_running')
  source $HOME/.vim/gvimrc
:endif
