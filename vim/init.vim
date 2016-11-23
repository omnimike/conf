set nocompatible

let mapleader = " "
set mouse=a
set list
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-expand-region'
"Plug 'Valloric/YouCompleteMe'
"Plug 'SirVer/ultisnips'
"Plug 'airblade/vim-rooter'
Plug 'amiorin/vim-project'
Plug 'daylerees/colour-schemes', {'rtp': 'vim'}
Plug 'terryma/vim-multiple-cursors'

call plug#end()

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set textwidth=0
set wrapmargin=0
set autoread
autocmd BufLeave,FocusLost * silent! wall
syntax enable
set directory=$HOME/.vim/swapfiles//

if has("gui_macvim")
    colorscheme earthsong
endif

" Syntastic configuration for jshint and jscs
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 0
autocmd FileType javascript let b:syntastic_checkers =
    \ findfile('.jscsrc', '.;') != '' ? ['jscs', 'jshint'] : ['jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = '☡'
let g:syntastic_style_warning_symbol = '¡'
let g:syntastic_enable_balloons = 1

let NERDTreeMapOpenInTab = '\r'

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .DS_Store
      \ -g ""'

let g:EasyMotion_smartcase = 1

" user defined functions
fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()

" quit
noremap <Leader>q :q<cr>

" run
noremap <Leader>as :!

" toggles
noremap <Leader>tp :set invpaste paste?<cr>
noremap <Leader>tn :set invnumber number?<cr>
noremap <Leader>ts :syntax enable<cr>
noremap <Leader>tt :NERDTreeFind<cr>

" files
noremap <Leader>s :w<cr>
noremap <Leader>p :tabedit<cr>:CtrlP<cr>
noremap <Leader>y :Welcome<cr>
noremap <Leader>b :e#<cr>

" easymotion
map <Leader>l <Plug>(easymotion-prefix)
nmap <Leader>; <Plug>(easymotion-overwin-f2)
map  <Leader>lf <Plug>(easymotion-bd-f)
nmap <Leader>lf <Plug>(easymotion-overwin-f)
map <Leader>ll <Plug>(easymotion-bd-jk)
nmap <Leader>ll <Plug>(easymotion-overwin-line)
map  <Leader>lw <Plug>(easymotion-bd-w)
nmap <Leader>lw <Plug>(easymotion-overwin-w)

" code/comments
noremap <Leader>cw :call TrimWhitespace()<cr>
noremap <Leader>cs :SyntasticCheck<cr>
" NERDCommenter commands

" vim
noremap <Leader>,r :source $MYVIMRC<cr>
noremap <Leader>,e :tabedit $MYVIMRC<cr>
noremap <Leader>,b :! conf save<cr>

" vim plug
noremap <Leader>,pi :PlugInstall<cr>
noremap <Leader>,pu :PlugUpdate<cr>
noremap <Leader>,pc :PlugClean<cr>

" git
noremap <Leader>g :! git 

" windows
" close
noremap <Leader>wc <C-w>c
" horizontal split
noremap <Leader>ws <C-w>s
" other
noremap <Leader>ww <C-w>w
" vertical split
noremap <Leader>wv <C-w>v
" only
noremap <Leader>wo <C-w>o
" left
noremap <Leader>wh <C-w>h
" down
noremap <Leader>wj <C-w>j
" up
noremap <Leader>wk <C-w>k
" right
noremap <Leader>wl <C-w>l
" move split right
noremap <Leader>w. 10<C-w>>
" move split left
noremap <Leader>w, 10<C-w><
" move split down
noremap <Leader>w- 10<C-w>-
" move split up
noremap <Leader>w+ 10<C-w>+
" balance split
noremap <Leader>w= 10<C-w>=
" maximize split
noremap <Leader>w\| <C-w>\|
" next tab
noremap <Leader>wn :tabnext<cr>
" previous tab
noremap <Leader>wp :tabprevious<cr>
" new tab
noremap <Leader>wt :tabedit %<cr>


" changing tabs
noremap <silent> <D-1> :tabn 1<cr>
noremap <silent> <D-2> :tabn 2<cr>
noremap <silent> <D-3> :tabn 3<cr>
noremap <silent> <D-4> :tabn 4<cr>
noremap <silent> <D-5> :tabn 5<cr>
noremap <silent> <D-6> :tabn 6<cr>
noremap <silent> <D-7> :tabn 7<cr>
noremap <silent> <D-8> :tabn 8<cr>
noremap <silent> <D-9> :tabn 9<cr>

noremap <silent> <Leader>1 :tabn 1<cr>
noremap <silent> <Leader>2 :tabn 2<cr>
noremap <silent> <Leader>3 :tabn 3<cr>
noremap <silent> <Leader>4 :tabn 4<cr>
noremap <silent> <Leader>5 :tabn 5<cr>
noremap <silent> <Leader>6 :tabn 6<cr>
noremap <silent> <Leader>7 :tabn 7<cr>
noremap <silent> <Leader>8 :tabn 8<cr>
noremap <silent> <Leader>9 :tabn 9<cr>

" projects

let g:project_use_nerdtree = 0
call project#rc()
Project 'conf', 'conf'
Project 'work/snippets', 'snippets'
call project#rc('~/vg/code')
Project 'api/questioneditor', 'editor'
Project 'api/questionsV2', 'questions'
Project 'api/schemas', 'schemas'
Project 'api/author', 'author'
Project 'site/docs', 'docs'
Project 'lib/spokenmath', 'spokenmath'
Project 'lib/mathcore', 'mathcore'
Project 'lib/scoring', 'scoring'

