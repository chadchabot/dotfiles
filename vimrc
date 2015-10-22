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
highlight LineNr ctermfg=red

" vim-indent-guides setup
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" vim-airline setup

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
set hlsearch
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
au WinLeave * setlocal nocursorline "maybe I like this, maybe I don't
au WinEnter * setlocal cursorline
set cursorcolumn
"auto commands? That is interesting. Could use those for window resizing?
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn

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

" split resizing is a pain, let's try this out
noremap < <C-w><
noremap > <C-w>>

" sane tab behaviour when in normal mode
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
noremap <BS> hx

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
noremap <leader>W :w!<Cr>
noremap <leader>e :e<Space>

" would be really cool to have this do something smart based on file context
noremap <leader>q :q<cr>
noremap <leader>Q :q!<cr>
noremap qq :q<cr>
noremap Q :q!<cr>
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
nnoremap <up> <C-w>+
nnoremap <down> <C-W>-
nnoremap <left> <C-w><
nnoremap <right> <C-w>>
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

" faster movement between tabs
nnoremap tt gt
nnoremap TT gT

" move the line below the current line down, but return to the current position
" on the current line
"inoremap <S-Enter> :$<Cr>

nnoremap i A
nnoremap A i

" while in insert mode, jk is a quick way to back out
inoremap jk <Esc>
inoremap jj <Esc>
inoremap kj <Esc>
" I like how shift+tab does the opposite of tab, so it makes sense to do the same for moving between words
noremap W b

" toggle invisible chars and show them textmate style
nmap <leader>l :set list!<Cr>
set listchars=tab:▸\ ,eol:¬

" quickly toggle between two files in a split
nnoremap <leader><leader>e <c-^>

" check syntax of coffeescript
" maybe change this to make it a more general purpose syntax aware linter?
" so when a file is opened an autocommand runs and sets up a key mapping for
" the linter/compiler/whatever tool is appropriate for that lang?
autocmd FileType coffee nnoremap <leader><leader>C :!coffee %<Cr>
" find all lines that have been marked debugger and comment them out
" it would be nice to have a way to toggle debugger calls with a single command
"autocmd FileType coffee nnoremap <leader><leader>dd :%s/debugger/#debugger/gi<cr>
autocmd FileType coffee nnoremap <leader><leader>dd :call ToggleJSDebugging()<cr>

function ToggleJSDebugging()
  echo "Called ToggleJSDebugging()"
endfunction

" easy open/close of NERDTree
nnoremap <leader>n :NERDTree<Cr>
nnoremap <leader><leader>n :NERDTreeClose<Cr>

" easy add to git
nnoremap <leader><leader>ga :!git add -p<Cr>
nnoremap <leader><leader>gc :!git commit<Cr>
nnoremap <leader><leader>gd :!git diff<Cr>
nnoremap <leader><leader>gdh :!git diff HEAD<Cr>
nnoremap <leader><leader>gl :!git l<Cr>
nnoremap <leader><leader>glp :!git log -p<Cr>
nnoremap <leader><leader>gpp :!git push<Cr>

"copy to shared clipboard; maybe remap the default y/p?
nnoremap <leader>y "*y
nnoremap <leader>p "*y
vnoremap <leader>y "*y
vnoremap <leader>p "*p

"an example of how autocommands can work
"use it to set tabstop and other whitespace prefs on a per language basis
"or to set up a linting/compiling shortcut key that will be language specific
"au Filetype ruby call SetRubyOptions()
"function SetRubyOptions()
"  echo "You're working on a Ruby file!"
"endfunction

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

autocmd Filetype gitcommit setlocal spell textwidth=72

" here is where I make poor decisions and hardcode my less/css lint preferences
" into shortcuts, which is probably the exact opposite of what I should be
" doing

" Find all class selectors that have attributes on a single line
"   Will also match on multiple attributes on one line
autocmd Filetype less nnoremap <leader><leader>M :%s/{\n\?[0-9a-zA-Z:. -@]\+;\n\?}//gn<Cr>
