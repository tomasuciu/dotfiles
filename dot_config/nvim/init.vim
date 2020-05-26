" Nvim Configuration File
syntax on

" Map Caps Lock to Escape, while preserving Escape functionality.
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x43 = Escape'
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Set up Vim-Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Vim-plug configuration settings
call plug#begin('~/.config/nvim/plugins')

" Allow for vim to be used as a text editor
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Retro color scheme
Plug 'morhetz/gruvbox'

" Autocomplete/lang server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'

" Functionality to switch between python virtualenvs
Plug 'jmcantrell/vim-virtualenv'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
call plug#end()

let mapleader = " "
nnoremap <Leader>n :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

map <C-f> <Esc><Esc>:Files!<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

func GoCoC()
    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    " GoTo code navigation.
    nmap <buffer> <leader>gd <Plug>(coc-definition)
    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    nmap <buffer> <leader>gi <Plug>(coc-implementation)
    nmap <buffer> <leader>gr <Plug>(coc-references)
    nmap <buffer> <leader>rr <Plug>(coc-rename)
    nnoremap <buffer> <leader>cr :CocRestart
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

autocmd FileType cpp,cxx,h,hpp,c,py :call GoCoC()
command! -nargs=* Wrap set wrap linebreak nolist

function! s:goyo_enter()
	Wrap
	noremap <buffer> <silent> j gj
	noremap <buffer> <silent> k gk
	noremap <buffer> <silent> <Up> gk
	noremap <buffer> <silent> <Down> gj
	noremap <buffer> <silent> <Home> g<Home>
	noremap <buffer> <silent> <End> g<End>
	Limelight
endfunction

function! s:goyo_leave()
	silent! nunmap <buffer> j
	silent! nunmap <buffer> k
	silent! nunmap <buffer> <Up>
	silent! nunmap <buffer> <Down>
	silent! nunmap <buffer> <Home>
	silent! nunmap <buffer> <End>
	Limelight!
endfunction

" Bind Goyo.vim and Limelight.vim
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Specify directory for virtualenv vim plugin
let g:virtualenv_directory = '$HOME/src/'

" Colorscheme settings.
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

" Vim Configuration
set number
set relativenumber

set showmatch
set smarttab
set nohlsearch
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set ts=4 sw=4
set ruler
set nowrap
set cursorline
