call pathogen#infect()

set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim

" start maximized
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif


"colorscheme github
"set background=dark 
"colorscheme ir_black
"colorscheme zenburn
"set background=light
"colorscheme bandit

" Solarized color scheme dark
syntax enable
set background=dark
colorscheme solarized

" Solarized color scheme light
"syntax enable
"set background=light
"colorscheme solarized

set ignorecase
set smartcase
set backspace=indent,eol,start


" make tab inserts instead of tabs at the begining of a line:
set smartindent

"""""""""""" Added for vim-tex """"""""""""""""
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
syntax on
filetype on
filetype plugin on
filetype indent on
syntax enable

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
"set iskeyword+=:

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*


" Font
set guifont=Consolas:h14:cDEFAULT

"set fencs=ucs-bom,utf-16le,utf-8,default,latin1
"set fencs=ucs-bom,utf-16le,unicode,utf-8,default
set fencs=ucs-bom,utf-8,default,latin1

" So you can change buffers without saving
set hidden

" Rempaaing ` to '
nnoremap ' `
nnoremap ` '
nnoremap <F5> :GundoToggle<CR>
inoremap <C-F> <C-R>"
nmap Y y$
nmap ,p o<ESC>p

nnoremap \ll :!start cmd "pdflatex %"<CR>
nnoremap \lv :silent !%:r.pdf<CR>
nnoremap <tab> %

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" No beeping
set visualbell

set spelllang=pl_PL

set enc=utf-8

" tabs
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
  
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" size of hard tabstop, width of tab character on screen
set tabstop=4
" size of an ident in visual and normal mode
set shiftwidth=4
" if less than tabstop, fist tab press will insert that many spaces
set softtabstop=4
" always uses spaces instead of tab characters
set expandtab

au FileType lua setl ts=2 sw=2 sts=2 et

" Highlighting searches
set incsearch
set showmatch
set hlsearch
set history=1000

" Numbers of lines always visible above and below current line
set scrolloff=3
set autoindent

set cursorline
" Relative line numbers
set relativenumber

" Create undo files, so undo data is not lost when file is exited
set undofile
" To not flood directories with vim files
 set backupdir-=.
 set undodir-=.
 set undodir^=$TEMP\\undo
 set backupdir^=$TEMP
 set directory=$TEMP\\\\

" Because it's local dummy, why should it behave like some remote terminal
set ttyfast
set laststatus=1

set wildmenu
set wildmode=list:longest

set clipboard+=unnamed

" Mark just pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'
nmap Y y$

" Enter working just as in insert in normal
nnoremap <silent> <CR> i<CR><Esc>
" Opposite of Shift-J
nnoremap <C-J> a<CR><Esc>k$

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

if has("win32")
    au GUIEnter * simalt ~x " x on an English Windows version. n on a French one
    set shell=powershell
    set shellcmdflag=-c
    set shellquote=\"
    set shellxquote=
    set shellpipe=|
    set shellredir=>
endif 

let &scrolloff=999-&scrolloff

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
runtime macros/matchit.vim

" Leader mappings
nnoremap ,u :GundoToggle<CR>
nmap <silent> ,n :silent :nohlsearch<CR>

" CtrlP plugin
let g:ctrlp_working_path_mode = 'ra'
nmap ,b :CtrlPBuffer<CR>
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
