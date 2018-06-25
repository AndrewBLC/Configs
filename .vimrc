set encoding=utf-8
let mapleader=' '
set nu
set hlsearch
set scrolloff=5
set mouse=v

" === Vundle setup ===
set nocompatible	" required
filetype off		" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/.vim/plugins/')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
" ...

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ajmwagar/vim-deus'
Plugin 'w0rp/ale'
Plugin 'jiangmiao/auto-pairs'

" ...
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" === Vundle setup ===

" explicitly define how splits occur
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" PEP8 indentation
au BufNewFile,BufRead *.py:
    \ set textwidth=79
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css:
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" YCM settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" syntax highlighting and linting
let python_highlight_all=1
syntax on
let g:ale_linters={
    \ 'javascript': ['jshint'],
    \ 'python': ['flake8'],
    \ 'go': ['go', 'golint', 'errcheck'],
    \}

" colour scheme
set t_Co=256
set termguicolors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme deus
let g:deus_termcolor=256


" hide .pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" airline setup
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='deus'

