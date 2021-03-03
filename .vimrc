set encoding=utf-8
call plug#begin()
Plug 'preservim/NERDTree'
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
"Plug 'powerline/powerline'
Plug 'dense-analysis/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'joshdick/onedark.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call plug#end()

"pretty code
let python_highlight_all=1
syntax on

"PEP-8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Enable folding
set foldmethod=indent
set foldlevel=99
nmap <space> za
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :NERDTreeFind<CR>
set number
