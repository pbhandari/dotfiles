" vim:foldenable

" Basic Things {{{

set nocompatible                " Revert all settings back to vim default

" Infect all the things
execute pathogen#infect('bundle/{}')

runtime macros/matchit.vim      " Better open/close matching

syntax on                       " Turn on Syntax hilighting
filetype on                     " Turn on filetype checking
filetype plugin on
filetype indent on
" }}}

"  General Config {{{
set bg=dark                     " Makes items more readable
set number                      " Line numbers are good
set ruler                       " Always show where you are in file

set guioptions-=T               " Disble Toolbar
set guifont=Monaco\ 8.5

set backspace=indent,eol,start  " Allow backspace in insert mode
set listchars=tab:>-,eol:$      " Catch trailing whitespaces

set showcmd                     " Show incomplete cmds down the bottom
set laststatus=2                " Always show the statusbar
set cmdheight=1                 " Set the height of the command line
set showtabline=1               " Always show tab-bar
set cursorline                  " Highlight current line

set visualbell                  " No sounds
set noerrorbells                " Don't beep

set pastetoggle=<F2>            " Enter paste-mode when F2
set autoread                    " Reload files changed outside vim
set autowrite                   " Write to file when changing buffers
set hidden                      " Buffers exist in the background
set switchbuf=useopen           " reveal already open files from the quickfix
                                " window, instead of opening new buffers

set scrolloff=3                 " Start scroll 3 lines before vert buffer ends
set sidescrolloff=3             " Start scroll 3 lines before horz buffer ends
set virtualedit=onemore         " Allow for cursor beyond last character
set viminfo='100,f1             " Save up to 100 marks, enable capital marks

set history=1000                " Store lots of :cmdline history
set nrformats-=octal            " Look up :h nrformat
set encoding=utf-8

set modeline                    " Enable modelines in vim

set autochdir                   " Automatically cd into `dir %`

let g:clipbrdDefaultReg = '+'   " Default Clipboard Registry = +
let mapleader = ','             " Map Leader is comma

" set list these characters
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪                 " show when the line is wrapped
set linebreak                   " line wrap on words not characters

set synmaxcol=800               " don't highlight massive lines
" }}}

" Backups and Undos {{{
set backup                      " Enable backups
" and move them to ~/.vim/tmp
set backupdir=~/.vim/tmp//,~/.tmp,~/tmp//,/var/tmp//,/tmp//
set directory=~/.vim/tmp//,~/.tmp,~/tmp//,/var/tmp//,/tmp//

if has("persistent_undo")
    " Keep undo history across sessions, by storing in file.
    " Only works all the time.
    set undodir=~/.vim/backups
    set undofile
endif
" }}}

" Indentation {{{
set autoindent                  " Autoindent by default
set copyindent                  " Use indent format of prev line, if autoindent

set tabstop=4                   " Show tabs as 4 spaces
set shiftwidth=4                " Tab goes forward 4 spaces
set softtabstop=4               " Virtual tab stop is also 4

set shiftround                  " Round tabulation to a multiple of /shiftwidth/
set expandtab                   " All tabs are spaces
" }}}

" Folds {{{
set foldmethod=marker          " Fold based on indent
set foldnestmax=3              " Deepest fold is 3 levels
set nofoldenable               " Dont fold by default
set foldopen=block,hor,insert  " Which commands trigger autofold
set foldopen+=jump,mark,percent,quickfix,search,tag,undo
" }}}

" Completion {{{
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.class
" }}}

" Search Settings  {{{
set ignorecase                  " Ignore case when searching
set smartcase                   " Unless search has a capital word in it

set incsearch                   " Find the next match as we type the search

set hlsearch                    " Highlight searches by default
set wrapscan                    " Wrap search upon reaching the end of document

" }}}

" Plugins {{{

" ================== NERDTree
nnoremap <leader><leader>e :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" ================= syntastic
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='★'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_warning_symbol='>'
let g:syntastic_mode_map={  'mode': 'active',
                         \  'passive_filetypes': ['c']}

"============== vim-powerline
if $TERM != "linux"
    let g:Powerline_symbols = 'fancy'
endif

"let g:Powerline_symbols_override = { 'LINE' : 'L' }
let g:Powerline_stl_path_style='short'
"let g:Powerline_colorsheme = 'solarized16'

" Don't show current mode down the bottom
set noshowmode

" ================== snipmate
let g:snips_author="Prajjwal Bhandari"

" ================= solarized
colorscheme solarized           " Better colouring

if !has('gui_running')
    let g:solarized_termcolors=&t_Co
endif

let g:solarized_termtrans=1

let g:solarized_contrast="high"
" Now Fix solarized annoyances

" ================== Sideways
nnoremap <silent> <leader><leader>h :SidewaysLeft<CR>
nnoremap <silent> <leader><leader>l :SidewaysRight<CR>

" ================== UndoTree
nnoremap <silent> <leader><leader>u :UndotreeToggle<CR>

" ================== Tagbar
nnoremap <silent> <leader><leader>t :TagbarToggle<CR>

" ================== HaskellMode
let g:haddock_indexfiledir="~/.vim/bundle/haskellmode-vim"
let g:haddock_browser="/usr/bin/firefox"
" }}}

" Filetypes {{{

" ================== Haskell
autocmd Filetype haskell setlocal makeprg=ghc\ %
autocmd BufEnter *.hs compiler ghc
let g:ghc = "/usr/bin/ghc"

" ================== Latex
autocmd Filetype tex setlocal makeprg=pdflatex\ % spell textwidth=78

" ================== Markdown
autocmd Filetype markdown setlocal spell textwidth=78

" }}}

" Highlight {{{
" Highlights lines over 80 chars,
highlight OverLine cterm=italic gui=italic ctermfg=red guifg=red
let OverLine = matchadd('OverLine', '\%>80v.\+')
autocmd ColorScheme * highlight OverLine cterm=italic ctermfg=red
autocmd ColorScheme * highlight OverLine gui=italic guifg=red

" Highlights trailing spaces with an ugly red background
highlight TrailSpace ctermbg=red guibg=red
let TrailSpace = matchadd('TrailSpace' , '\s\+$')
autocmd ColorScheme * highlight TrailSpace ctermbg=red guibg=red

" }}}

" Remaps {{{
" Easy precision
nnoremap ' `
nnoremap ` '

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Show whitespaces
nmap <silent> <leader>s :set nolist!<CR>

" Clear highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Quick write read only Files
cmap w!! w !sudo tee % >/dev/null

" Y works the same as C, and D
nnoremap Y y$

" Switch between absolute and relative line numbers
nnoremap <silent> <leader><leader>n
            \ :exec "set " .((&number == 1)? "relative" : "") . "number"<CR>

" quick and easy make
nnoremap <leader>mk :make<CR>

" quick esacpes
inoremap qq <ESC>

" Help key is not helpful
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ,dX deletes a line without adding it to yank stack: normal and visual mode.
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d
nnoremap <silent> <leader>D "_D
vnoremap <silent> <leader>D "_D

" ,cX changes a line without adding it to yank stack: normal and visual mode.
nnoremap <silent> <leacer>c "_c
vnoremap <silent> <leacer>c "_c
nnoremap <silent> <leacer>C "_C
vnoremap <silent> <leacer>C "_C

" }}}

" Autocmds and Functions{{{
autocmd CursorHoldI * stopinsert
autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=10000
autocmd InsertLeave * let &updatetime=updaterestore

"remove whitespace before writing to any file
autocmd BufWrite,FileWritePre * call RemoveWhiteSpace()
autocmd FileType markdown let b:noStripWhitespace=1
autocmd FileType markdown call matchdelete(TrailSpace)

" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
    if exists('b:noStripWhitespace')
        return
    endif
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal 'z"
endfunction
" }}}

" OVERRIDES {{{
autocmd BufEnter * set cmdheight=1
" }}}

