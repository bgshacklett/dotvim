" disable syntax helpers until other resources are loaded.
syntax off
filetype plugin indent off

" Fix Windows' path oddities.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Load Pathogen
source $HOME/.vim/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

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

" General Preferences
set hlsearch
set ruler

" Set colorscheme for 256 color mode.
if &t_Co > 16
	colors grb256-custom
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>

" Enable, and configure hidden chars
set list
set listchars=tab:»\ ,eol:¬
