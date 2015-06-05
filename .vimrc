" requires pathogen to be installed
" i don't have any fancy way to do this yet, scripted or otherwise
" so this is pretty basic so far
filetype off
execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set modelines=0
set ruler
set wrap
set textwidth=79
set colorcolumn=85
set formatoptions=qrn1
set encoding=utf-8

set mouse=a
set mousefocus
set mousemodel=extend
set selectmode=mouse

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set scrolloff=10
set cursorline
set autoindent
set visualbell
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest

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

" defaults for start and end of a line are stupid and so far from homerow keys
noremap H ^
noremap L $

" it's way more common that I'm deleting an entire word 
" than deleting from my current cursor position to the end of the word
noremap dw daw
noremap daw dw

" if i'm working with long lines (don't do it!) this moves based on displayed lines,
" not 'physical' lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" i'm used to pagination working with the spacebar
"nnoremap <Space> <C-D>
"nnoremap <S-Space> <C-U> " this fails because vim only receives the charcode
"for the spacebar, ignoring the shift modifier

" Space is the easiest key to reach by both hands, and allows for way more interesting keybindings
let mapleader = "\<Space>"
" stop that stupid window from popping up
map q: :q

" quick common actions
noremap <leader>w :w<Cr>
noremap <leader>e :e 
" would be really cool to have this do something smart based on file context
noremap <leader>q :q<cr>

" force myself to use the hjkl keys for navigation
nnoremap <up> <nop>
nnoremap <down> <nop>

nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" i rarely want to insert right where the cursor is, but do want to add to the end of the current word
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
