" disable syntax helpers until other resources are loaded.
syntax off
filetype plugin indent off

" Fix Windows' path oddities.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
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
set shiftwidth=4
set tabstop=4
set softtabstop=4

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

" If running inside of ConEmu, 256-color support is available.
if $ConEmuPID
    set t_Co=256
endif

" Set colorscheme for 256 color mode.
if &t_Co > 16
	colors grb256-custom
endif

if has('gui_running')
    colors one
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>

" Enable, and configure hidden chars
set list
set listchars=tab:»\ ,eol:¬
