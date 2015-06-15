" requires pathogen to be installed
" i don't have any fancy way to do this yet, scripted or otherwise
" so this is pretty basic so far
filetype off
execute pathogen#infect()
syntax enable
filetype plugin indent on

set nocompatible
set modelines=0
set ruler
set wrap
set textwidth=79
set colorcolumn=85
set formatoptions=qrn1
set encoding=utf-8

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set backupdir=$HOME/.vim/backup "could get rid of this I guess
set nobackup
set noswapfile
set nolazyredraw
set ch=2
set report=0
set autoread

set mouse=a
set mousefocus
set mousemodel=extend
set selectmode=mouse
set title
set shortmess=atI
set showmatch
set clipboard=unnamed

set backspace=indent,eol,start
set incsearch
set ignorecase "case insensitive searching
set smartcase "however, if I *do* include a capital letter, search is case sensitive

set smartindent
set formatoptions+=n
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set scrolloff=10
set cursorline
set autoindent
set copyindent
set visualbell
set noerrorbells
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=longest,list,full
set laststatus=2

" i think the visual selection mode keys are backwards
noremap v V
noremap V v

" a little fancy thing to maintain selection in visual mode after indent action
noremap < <gv
noremap > >gv

" sane tab behaviour when in normal mode
nnoremap < v<<Esc>
nnoremap > v><Esc>
nnoremap <S-Tab> v<<Esc>
nnoremap <Tab> v><Esc>

" while in visual mode, make it easy to indent stuff
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" pressing enter should be different from navigating up/down; 
" just add the damn newline on the line that i'm on, shifting things down
nnoremap <Enter> ^i<Cr><Esc>
" of course, maybe you mean to put the newline below the current line. I can't
" read your mind
" this needs to be fixed, it doesn't maintain the tab indent level of the line
" below
nnoremap <S-Enter> :$<Cr><Esc>

" defaults for start and end of a line are stupid and so far from homerow keys
noremap H ^
noremap L $

" it's way more common that I'm deleting an entire word 
" than deleting from my current cursor position to the end of the word
noremap dw daw
noremap daw dw

" get 'normal' outcome from pressing the backspace key in normal mode
noremap <BS> x

" look into https://github.com/haya14busa/incsearch.vim for improved searching

" if i'm working with long lines (don't do it!) this moves based on displayed lines,
" not 'physical' lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" no need for awkward shift key pressing to enter commands
nnoremap ; :

" Space is the easiest key to reach by both hands, and allows for way more interesting keybindings
let mapleader="\<Space>"
" quick common actions
noremap <leader>w :w<Cr>
noremap <leader>e :e 
" would be really cool to have this do something smart based on file context
noremap <leader>q :q<cr>
noremap <leader>z <C-z>

" page up/down is obnoxious with standard keys; may use the leader?
noremap <leader>k <C-b>
noremap <leader>j <C-d>
" easier redo, though I was thinking about making it shift-u, like with tabbing
noremap <leader>r <C-r> 

" faster search and replace
noremap <leader>f :s/
noremap <leader>F :%s/

" stop that stupid window from popping up
map q: :q

" force myself to use the hjkl keys for navigation
nnoremap <up> <nop>
nnoremap <down> <nop>

nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

set splitbelow
set splitright

" faster nav between splits
nnoremap <leader><leader>h <C-W><C-H>
nnoremap <leader><leader>j <C-W><C-J>
nnoremap <leader><leader>k <C-W><C-K>
nnoremap <leader><leader>l <C-W><C-L>

" move the line below the current line down, but return to the current position
" on the current line
"inoremap <S-Enter> :$<Cr>

nnoremap i A
nnoremap A i

" while in insert mode, jk is a quick way to back out 
inoremap jk <Esc>
inoremap jj <Esc>
" I like how shift+tab does the opposite of tab, so it makes sense to do the same for moving between words
noremap W b

" toggle invisible chars and show them textmate style
nmap <leader>l :set list!<Cr>
set listchars=tab:▸\ ,eol:¬

" quickly toggle between two files in a split
nnoremap <leader><leader>e <c-^>
