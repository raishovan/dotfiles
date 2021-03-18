	set encoding=utf-8
call plug#begin()
Plug 'preservim/NERDTree'
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'dense-analysis/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'joshdick/onedark.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'majutsushi/tagbar'                  " Class/module browser
call plug#end()

" Sytastic Settings
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_flake8_max_line_length="160"

"pretty code
let python_highlight_all=1
syntax on

"PEP-8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Enable folding
set foldmethod=indent
set foldlevel=99

set incsearch
set scrolloff=8
set signcolumn=yes

nmap <space> za
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :NERDTreeFind<CR>
:nnoremap <F5> :buffers<CR>:buffer<Space>
"set number
:set number relativenumber

"clipboard
vnoremap <C-y> "+y
map <C-p> "+p
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set mouse=a
"mouse support for alacritty
set ttymouse=sgr


"=====================================================
""" TagBar settings
""=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)

:let g:session_autoload = 'no'
