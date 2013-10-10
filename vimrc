" Fix Windows' path oddities.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Load Pathogen
source $HOME/.vim/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on

filetype plugin indent on

" Configure indentation
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" General Preferences
set hlsearch
set ruler

" Set colorscheme for 256 color mode.
if &t_Co > 16
	colors grb256
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>
