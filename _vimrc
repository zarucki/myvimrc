call pathogen#infect()
call pathogen#helptags()

set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim

let mapleader=","
noremap \ ,

" start maximized
if has("gui_running")
    if has("win32")
        " GUI is running or is about to start.
        " Maximize gvim window.
        au GUIEnter * simalt ~x " x on an English Windows version. n on a French one
    endif

    set guioptions-=mT
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

if has("gui_running")
    set background=dark
    colorscheme solarized
endif

" Solarized color scheme light
"syntax enable
"set background=light
"colorscheme solarized

set ignorecase
if exists("&wildignorecase")
    set wildignorecase
endif
" set smartcase
set backspace=indent,eol,start
" to not break in the middle of the word
set linebreak
" to indicate that the line is not a new line but continuation of the previous one
set showbreak=…
" to show partial line even if they don't fit on screen
set display+=lastline
" so jkhl acts on logical lines
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" make tab inserts instead of tabs at the begining of a line:
set smartindent

"""""""""""" Added for vim-tex """"""""""""""""
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
syntax on
filetype on
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete
syntax enable

set grepprg=grep\ -n

" Font
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13:cDEFAULT
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13


"set fencs=ucs-bom,utf-16le,utf-8,default,latin1
"set fencs=ucs-bom,utf-16le,unicode,utf-8,default
set fencs=ucs-bom,utf-8,default,latin1

" So you can change buffers without saving
set hidden

" Rempaaing ` to '
nnoremap ' `
nnoremap ` '
inoremap <C-F> <C-R>"
nnoremap <C-tab> :b #<CR>
nmap Y y$

nmap <Leader>p o<ESC>p

nnoremap R "_d
vnoremap R "_d

nnoremap \ll :!start cmd "pdflatex %"<CR>
nnoremap \lv :silent !%:r.pdf<CR>

" execute last substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

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
set scrolloff=2
set autoindent

set cursorline
" Relative line numbers
set relativenumber
" Since vim 7.4 you can have both turned on
set number

" Create undo files, so undo data is not lost when file is exited
set undofile
" To not flood directories with vim files
set backupdir-=.
set undodir-=.
set directory-=.

" Because it's local dummy, why should it behave like some remote terminal
set ttyfast
set laststatus=1

set wildmenu
set wildmode=list:full

" Mark just pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'
nmap Y y$

" Horizontaly center on cursor
nnoremap z<Bslash> zszH

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

if has("win32")
    " set shellslash
    set shellredir=>
    set shellquote=\"
    set shellxquote=
endif 

" Always centered
" let &scrolloff=999-&scrolloff

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" So c-p and c-n also filters the history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

runtime macros/matchit.vim

nnoremap <Leader>u :GundoToggle<CR>
nmap <silent> <Leader>n :silent :nohlsearch<CR>

" CtrlP plugin
let g:ctrlp_working_path_mode = 'ra'
nmap <Leader>b :CtrlPBuffer<CR>
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" dbext
let g:dbext_default_profile_mySQLServer = 'type=SQLSRV:integratedlogin=1:host=localhost'
let g:dbext_default_profile = 'mySQLServer'
let g:dbext_default_SQLSRV_cmd_options = '-w 65536 -b -n -m-1 -s !'
"let g:ftplugin_sql_omni_key = '<C-S>'

nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %H:%M:%S")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %H:%M:%S")<CR>

" For syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }


" snipmate
" let g:UltiSnipsExpandTrigger="<C-Space>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetsDir=$VIM . '\vimfiles\snippets'
let g:UltiSnipsEditSplit='horizontal'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

" supertab
set completeopt=menu,menuone,preview,longest
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabLongestEnhanced=1

set laststatus=2
let g:airline_powerline_fonts = 1
" because fugitive is not working -_-
let g:airline_section_b = ''

if has("win32")
    set clipboard+=unnamed
    set undodir^=$TEMP//
    set backupdir^=$TEMP//
    set directory^=$TEMP//
else
    cmap w!! w !sudo tee > /dev/null %
    set clipboard=unnamedplus
    set undodir^=~/.vim/vimfiles/undofiles//
    set backupdir^=~/.vim/vimfiles/backupfiles//
    set directory^=~/.vim/vimfiles/swapfiles//
endif

" For vim-fontsize
set timeoutlen=3000
nmap <silent> <Leader>=  <Plug>FontsizeBegin
