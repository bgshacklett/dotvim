" Fix Windows' path oddities.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

source $HOME/.vim/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on

filetype plugin indent on
