"
" Force the use of specific python venv
" TODO: We should be able to handle this in a more graceful way for
"       a cross-platform config
let g:python3_host_prog = $HOME . '/.pyenv/versions/editor/bin/python3'


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
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'

"" Java
Plug 'mfussenegger/nvim-jdtls'  " for github.com/eclipse-jdtls/eclipse.jdt.ls
"" Rust
Plug 'simrat39/rust-tools.nvim'  ", { 'for': ['rust'] }

" Debugging
Plug 'nvim-lua/plenary.nvim'  " LUA functions for Neovim
Plug 'mfussenegger/nvim-dap'  " Debug Adapter Protocol client


" " Plug 'amitds1997/remote-nvim.nvim', { 'branch': 'feat/support-freebsd' }
"   Plug 'nvim-lua/plenary.nvim'
"   Plug 'MunifTanjim/nui.nvim'
"   Plug 'rcarriga/nvim-notify'
"   " This would be an optional dependency eventually

" GH CoPilot
Plug 'github/copilot.vim', { 'on': 'Copilot' }

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'

" Preview Tools
Plug 'shime/vim-livedown'

" UI
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
"   Themes
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'

" Git Integrations
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'borissov/fugitive-bitbucketserver'
Plug 'rbong/vim-flog'
Plug 'lewis6991/gitsigns.nvim'

" Syntax ranges and regions
Plug 'vim-scripts/SyntaxRange'
Plug 'chrisbra/NrrwRgn'

" Language Enhancements
Plug 'elzr/vim-json'
Plug 'rodjek/vim-puppet'
Plug 'PProvost/vim-ps1'
Plug 'Rykka/InstantRst'
"" C#
Plug 'OrangeT/vim-csharp'
Plug 'OmniSharp/omnisharp-vim'
" --
Plug 'pedrohdz/vim-yaml-folds'
Plug 'epcim/vim-chef'
Plug 'vito-c/jq.vim'
Plug 'hashivim/vim-vagrant'
Plug 'hashivim/vim-packer'
Plug 'towolf/vim-helm'
Plug 'Glench/Vim-Jinja2-Syntax'
"" Python
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
" --

" Terminal/Environment Integrations
Plug 'bgshacklett/vitality.vim'

Plug 'powerman/vim-plugin-AnsiEsc'

" Feature Enhancements
Plug 'Yggdroot/indentLine'  " No longer maintained
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'wfaulk/iRuler.vim'

" Diagnostics
Plug 'folke/trouble.nvim'
Plug 'nvim-tree/nvim-web-devicons' " Dependency of trouble.nvim, and others

" JenkinsFile Linter
Plug 'ckipp01/nvim-jenkinsfile-linter'
Plug 'nvim-lua/plenary.nvim'  " Dependency of nvim-jenkinsfile-linter

" General Syntax
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Helpers
Plug 'tpope/vim-unimpaired'
Plug 'gregsexton/MatchTag'
Plug 'godlygeek/tabular'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'sagarrakshe/toggle-bool'
Plug 'tpope/vim-commentary'

" File Exploring
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'ThePrimeagen/git-worktree.nvim'

" Distraction Free Writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

lua require("mason").setup()


let g:UltiSnipsDebugServerEnable=0
    " (bool) Set to 1 to Enable the debug server. If an exception occurs or
    " a breakpoint (see below) is set, a Pdb server is launched, and you can
    " connect to it through telnet.

let g:UltiSnipsDebugHost='localhost'
    " (string) The host the server listens on

let g:UltiSnipsDebugPort=8080
    " (int) The port the server listens to

let g:UltiSnipsPMDebugBlocking=0
    " (bool) Set whether the post mortem debugger should freeze vim.
    " If set to 0, vim will continue to run if an exception
    " arises while expanding a snippet and the error message describing the
    " error will be printed with the directives to connect to the remote
    " debug server. Internally, Pdb will run in another thread and the session
    " will use the python trace back object stored at the moment the error
    " was caught. The variable values and the application state may not reflect
    " the exact state at the moment of the error.
    " If set to 1, vim will simply freeze on the error and will resume
    " only after quiting the debugging session (you must connect via telnet
    " to type the Pdb's `quit` command to resume vim). However, the
    " execution is paused right after caughting the exception, reflecting
    " the exact state when the error occured.


" Set updatetime to a (nearly) imperceptible value to help git-gutter and some
" other plugins work more efficiently.
set updatetime=250


" Configure Completion
set completeopt=menu,menuone,noselect
lua require('bgshacklett.completion')
lua require('gitsigns').setup()

" Configure Fern
noremap <silent> <C-f> :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=


" Git related configs
let g:fugitive_bitbucketservers_domains = ['http://tnc.bitbucket.org']
lua require('bgshacklett.git-worktree')
lua require('gitsigns').setup {}


" Configure FireNVim
let g:firenvim_config = {
    \ 'globalSettings': {
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }


" Copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


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


" Syntax Highlighting
let g:python_highlight_all = 1
let g:markdown_syntax_conceal = 0  " Don't conceal characters; it's annoying.
lua require('bgshacklett.treesitter')

" Configure indentation
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Configure Folding
nnoremap <Space> za
vnoremap <Space> za

" General Preferences
set hlsearch
set ruler
set laststatus=2  " Always enable status bar
set number
set wrap!  " Don't wrap long lines

" Set up 256 color mode.
if &t_Co > 16
  set termguicolors
endif

" Disable the Delete key in normal mode
nnoremap <DEL> <Nop>

" Enable, and configure hidden chars
set list
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:␣,trail:•

set colorcolumn=80

set relativenumber

colors one
set background=dark
hi ColorColumn guibg=#444444

lua << END
require('lualine').setup({})
END


set inccommand=nosplit

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

lua << LUA
require('lualine').setup()
LUA

"Folding
" set foldopen=hor,mark,percent,quickfix,search,tag,undo

" augroup AutoSaveFolds
"   autocmd!
"   " autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

" Import LSP Configuration
lua require('bgshacklett.lspconfig')

lua <<LUA
-- Trouble:
-- A pretty diagnostics, references, telescope results, quickfix and location
-- list to help you solve all the trouble your code is causing.
require("trouble").setup({
  -- your configuration comes here
  -- see https://github.com/folke/trouble.nvim for details
})

LUA


nnoremap q: <nop>


" Custom commands
:command Res source $MYVIMRC
:command Unf %s/\s\+$//e


" Hexmode
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif


runtime zen.vim
