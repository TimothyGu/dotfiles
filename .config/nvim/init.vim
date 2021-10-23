let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if executable('opam')
  let g:opamshare = substitute(system('opam var share'),'\n$','','''')
  execute "set rtp+=" . g:opamshare . "/merlin/vim"
endif

call plug#begin('~/.local/share/nvim/plugins')
Plug 'editorconfig/editorconfig-vim'
Plug 'tmsvg/pear-tree'
Plug 'tomtom/tcomment_vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
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
Plug 'HerringtonDarkholme/yats.vim', {'for': 'typescript'}

Plug '~/dev/cr/v8/v8/tools/torque/vim-torque'

call plug#end()

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

let g:deoplete#enable_at_startup = 1

if $TERM !=# 'linux'
  let g:airline_powerline_fonts = 1
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  set background=light
  colorscheme solarized8
else
  let g:airline_symbols_ascii = 1
endif

set lazyredraw

set cursorline
set cursorcolumn
set ruler
set nojoinspaces

set relativenumber
let mapleader = ","
nmap <Leader><CR> O<Esc>

set hlsearch
set mouse=a

autocmd BufWritePre,BufRead *.mjs set filetype=javascript
autocmd BufWritePre,BufRead *.jbuilder set filetype=ruby

" https://github.com/dense-analysis/ale/issues/1645#issuecomment-396414319
function ALELSPMappings()
  let l:lsp_found=0
  for l:linter in ale#linter#Get(&filetype)
    if !empty(l:linter.lsp)
      let l:lsp_found=1
    endif
  endfor
  if (l:lsp_found)
    nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
    nnoremap <buffer> <C-^> :ALEFindReferences<CR>
  else
    silent! unmap <buffer> <C-]>
    silent! unmap <buffer> <C-^>
  endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
