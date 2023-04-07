call plug#begin()

" GRUVBOX
Plug 'morhetz/gruvbox'

" WHICH-KEY
" Plug 'liuchengxu/vim-which-key'

" RANGER
Plug 'kevinhwang91/rnvimr'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"
" " UTILS
"Plug 'tpope/vim-commentary'
"Plug 'jiangmiao/auto-pairs'
"Plug 'prettier/vim-prettier'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
call plug#end()

" GRUVBOX
autocmd vimenter * ++nested colorscheme gruvbox

" FZF
let g:fzf_preview_window = ['right,50%', 'ctrl-/']
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git -o -name .next \) -prune -o -print'
let $FZF_DEFAULT_OPTS="--bind \"ctrl-d:preview-down,ctrl-u:preview-up\""
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always'
let g:fzf_tags_command = 'ctags -R'
nnoremap <space>fb :Buffers<CR>
nnoremap <C-g> :GFiles!?<CR>
nnoremap <Leader>f :Rg!<space>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" COC
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" SETS
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set number
set relativenumber
set ignorecase
set smartcase
set nowrap
set mouse=
set expandtab
set clipboard=unnamedplus
set background=dark

" REMAP
inoremap jk <Esc>
inoremap kj <Esc>
let mapleader = ","
nnoremap <silent> <space>z :RnvimrToggle<CR>
nnoremap <C-p> "*p
vnoremap <C-y> "*y

