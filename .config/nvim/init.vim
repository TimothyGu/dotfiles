let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if executable('opam')
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
endif

call plug#begin('~/.local/share/nvim/plugins')
Plug 'editorconfig/editorconfig-vim'
Plug 'tmsvg/pear-tree'
Plug 'tomtom/tcomment_vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-sleuth'
Plug 'wlangstroth/vim-racket'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'copy/deoplete-ocaml'
call plug#end()

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

let g:deoplete#enable_at_startup = 1

set termguicolors

set background=light
colorscheme solarized8
set lazyredraw

set cursorline
set cursorcolumn
set ruler
set nojoinspaces

set relativenumber
let mapleader = ","
nmap <Leader><CR> O<Esc>

" set hlsearch
set mouse=a

autocmd BufWritePre,BufRead *.mjs set filetype=javascript
