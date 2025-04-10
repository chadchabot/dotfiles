
" requires pathogen to be installed, which is taken care of by vim-setup.sh
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
"set paste "this is the preferred behaviour when actually pasting into vim,
           "preventing all of those extraneous and incorrect newlines, buy it'd
           "not helpful in other contexts.

set backspace=indent,eol,start
set hlsearch
set incsearch
set ignorecase "case insensitive searching

set magic "TODO: I'm not sure what this does, but it sounds like a good thing

set smartcase "however, if I *do* include a capital letter, search is case sensitive

set nojoinspaces " use one space, not two, after punctuation
set smartindent
set formatoptions+=n
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set number
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
set wildmode=longest,list,full
set wildmenu
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
nnoremap <CR> ^i<Cr><Esc>
" of course, maybe you mean to put the newline below the current line. I can't
" read your mind
" this needs to be fixed, it doesn't maintain the tab indent level of the line
" below
nnoremap <S-CR> gj$i<Cr><Esc>

" defaults for start and end of a line are stupid and so far from homerow keys
noremap H ^
noremap L $

" it's way more common that I'm deleting an entire word
" than deleting from my current cursor position to the end of the word
noremap dw daw
noremap daw dw

"TODO: allow for command delete, like mac os x
"      which would delete an entire line
"      and option-delete which would delete up to the beginning of the current
"      word, including spaces between the cursor and the word

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
nmap <silent> <leader>/ :nohlsearch<cr>

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

"TODO: broken
autocmd FileType coffee nnoremap <leader><leader># :call CommentLines()<cr>
function CommentLines()
  echo "Called CommentLines()"
  normal gv"xy
  let result = getreg("x")
  echo result
endfunction


"TODO: fill this in so it works!
function ToggleJSDebugging()
  echo "Called ToggleJSDebugging()"
  "find all instances of "debugger" and set to "#debugger"
  "find all instances of "#debugger" and set to "debugger"
endfunction

" easy open/close of NERDTree
nnoremap <leader>n :NERDTree<Cr>
nnoremap <leader><leader>n :NERDTreeClose<Cr>
"let NERDTreeShowHidden=1 "do you need to see hidden files all the time? It's a single "I" away from being visible at any point.
"nnoremap <leader>n :E<Cr> "I'm undecided whether I like having nerdtree stay
"open or not.

" easy add to git
nnoremap <leader><leader>ga :!git add -p<Cr>
nnoremap <leader><leader>gc :!git commit<Cr>
nnoremap <leader><leader>gd :!git diff<Cr>
nnoremap <leader><leader>gdh :!git diff HEAD<Cr>
nnoremap <leader><leader>gl :!git l<Cr>
nnoremap <leader><leader>glp :!git log -p<Cr>
nnoremap <leader><leader>gpp :!git push<Cr>

"copy to shared clipboard; maybe remap the default y/p?
nnoremap <leader>y +y
nnoremap <leader>p "*y
vnoremap <leader>y "*y
vnoremap <leader>p "*p

nnoremap <leader><leader>p :call TogglePaste()<cr>
function TogglePaste()
  if &paste
    set nopaste
  else
    set paste
  endif
endfunction

"an example of how autocommands can work
"use it to set tabstop and other whitespace prefs on a per language basis
"or to set up a linting/compiling shortcut key that will be language specific
"au Filetype ruby call SetRubyOptions()
"function SetRubyOptions()
"  echo "You're working on a Ruby file!"
"endfunction

autocmd BufNewFile,BufRead Gemfile*,Guardfile* set filetype=ruby

"autocmd BufNewFile,BufRead *.slim set filetype=slim

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m

  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
"nnoremap K :grep! "\b,C-R><C-W>\b"<CR>:cw<CR>

"nmap <silent> <leader><leader>s :set spell!<CR>"not sure if I want spellcheck
"on always, or toggled, so leave this here to decide on later

set spelllang=en_ca
autocmd Filetype gitcommit setlocal spell textwidth=72

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd Filetype markdown setlocal spell

" here is where I make poor decisions and hardcode my less/css lint preferences
" into shortcuts, which is probably the exact opposite of what I should be
" doing

" Find all class selectors that have attributes on a single line
"   Will also match on multiple attributes on one line
autocmd Filetype less nnoremap <leader><leader>M :%s/{\n\?[0-9a-zA-Z:. -@]\+;\n\?}//gn<Cr>

" convert file to binary/hex format
noremap <leader>hh :% ! xxd<Cr>
noremap <leader>HH :% ! xxd -r<Cr>"

" protect against lazy writing and anti-inclusive language
" courtesy of Jess Telford @jesstelford
highlight badWords ctermbg=red ctermfg=white

fun! HiBadWords()
  match badWords /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfun

" This may be useful files other than markdown.
autocmd InsertEnter *.md call HiBadWords()
autocmd InsertLeave *.md call HiBadWords()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Some new stuff I added to make working with markdown files a little nicer.
" I fully expect there are great plugins that would do this for me, but I'm all for trying weird stuff and learning
""""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=85
" What does the `q` do?
"   this automatically reformats text to fit within the textwidth setting.
"   in my case, this means text auto wraps when I reach the 80th column.
" What does the `r` do?
"   automatically insert the current comment leader after hitting enter in
"   Insert mode
" What does the `n` do?
"   If a line starts with -, *, or 1. (a list item), Vim will automatically
"   insert the same character on the new line.
" What does the `1` do?
"   do not break a line after a one-letter word, break before it, if possible.
set formatoptions=qrn1
" Tell vim what a list item character can look like.
" List Characters and Regex Pattern for Format List
" +--------------------+---------------------------+
" | List Character     | Regex Pattern             |
" +--------------------+---------------------------+
" | -                  | ^\s*[-*+]\s               |
" | *                  | ^\s*[-*+]\s               |
" | +                  | ^\s*[-*+]\s               |
" | 1.                 | ^\s*\d\+\.\\s             |
" +--------------------+---------------------------+
"set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+
"set formatlistpat=^\s*[-*+]\s\+\|\s*\d\+\.\s\+
set formatlistpat=^\s*[-*+]\s\+\|\s*\d\+\.\s\+


" there is a default value for tabstop=4 for md files on my work machine.
" I want to override that and have it use tabstop=2, like I have for most other
" file types
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Override formatlistpat for markdown files to detect list items
autocmd FileType markdown setlocal formatlistpat=^\s*[-*+]\s\+\|\s*\d\+\.\s\+

" Enables list continuation (e.g., pressing Enter continues the list)
autocmd FileType markdown setlocal formatoptions-=q formatoptions-=r
" prevent auto reformat of long lines in a markdown file. text will still softwrap
autocmd FileType markdown setlocal textwidth=0
" show where column 80 is visually
autocmd FileType markdown setlocal colorcolumn=80
autocmd FileType markdown highlight ColorColumn ctermbg=darkgray guibg=yellow

function! DefineIndentMappings()
  if !exists('g:indentMap')
    let g:indentMap = { -1: "\<C-d>", 0: "", 1: "\<C-t>" }
  endif
endfunction

function! GetNumberedListMarker()
  let l:line = getline('.')

  if l:line =~ '^\s*\d\+\.'
    let l:number = matchstr(l:line, '^\s*\d\+')
    return l:number
  endif

  return ''
endfunction

" Function to increment the number in a numbered list
function! InsertNumberedListMarker(number, indent)
  let l:prefix = get(g:indentMap, a:indent, "")

  let l:resetNumber = a:indent
  " if we are indenting, we need to reset the list item number to 1
  " else increment
  let l:nextnum = l:resetNumber ? 1 : str2nr(a:number) + 1
  return "\<CR>" . l:prefix . l:nextnum . ". "
endfunction

function! GetPlainListMarker()
  let l:listMarkers = '[-*+]'
  let l:pattern = printf('^\s*\zs%s\+', l:listMarkers)
  return matchstr(getline('.'), l:pattern)
endfunction

function! InsertPlainListMarker(marker, indent)
  let l:prefix = get(g:indentMap, a:indent, "")
  return "\<CR>" . l:prefix . a:marker . " "
endfunction

" Function to detect the list marker and insert the next item
function! InsertListItemMarker(addTab)
  " Check if the current line starts with a plain list marker
  let l:plainListMarker = GetPlainListMarker()
  if l:plainListMarker != ''
    return InsertPlainListMarker(l:plainListMarker, a:addTab)
  endif

  let l:numberedListMarker = GetNumberedListMarker()
  if l:numberedListMarker != ''
    return InsertNumberedListMarker(l:numberedListMarker, a:addTab)
  endif

  " If no list marker is found insert a normal line break
  return "\<CR>"
endfunction

function! InsertListItemMarkerNoTab()
  let l:indent = 0
  return InsertListItemMarker(l:indent)
endfunction

function! InsertListItemMarkerIncreaseIndent()
  let l:indent = 1
  return InsertListItemMarker(l:indent)
endfunction

function! InsertListItemMarkerDecreaseIndent()
  let l:indent = -1
  return InsertListItemMarker(l:indent)
endfunction

" Automatically trigger list insertion behavior in markdown files
autocmd FileType markdown call DefineIndentMappings()
autocmd FileType markdown inoremap <expr> <CR> InsertListItemMarkerNoTab()
autocmd FileType markdown inoremap <expr> <M-CR> InsertListItemMarkerIncreaseIndent()
autocmd FileType markdown inoremap <expr> <C-M-CR> InsertListItemMarkerDecreaseIndent()

" add marker management when entering a md buffer
autocmd BufEnter *.md call DefineIndentMappings()
autocmd BufEnter *.md inoremap <expr> <CR> InsertListItemMarkerNoTab()
autocmd BufEnter *.md inoremap <expr> <M-CR> InsertListItemMarkerIncreaseIndent()
autocmd BufEnter *.md inoremap <expr> <C-M-CR> InsertListItemMarkerDecreaseIndent()

" Remove all of the list marker management listeners when leaving a markdown
" file
autocmd BufLeave *.md iunmap <CR>
autocmd BufLeave *.md iunmap <M-CR>
autocmd BufLeave *.md iunmap <C-M-CR>
autocmd BufLeave *.md unlet! g:indentMap
