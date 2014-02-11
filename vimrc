" .vimrc

" Basic Things {{{

set nocompatible                " Revert all settings back to vim default

" Infect all the things
execute pathogen#infect('bundle/{}')

runtime macros/matchit.vim      " Better open/close matching

syntax on                       " Turn on Syntax hilighting
filetype on                     " Turn on filetype checking
filetype plugin on
filetype indent on

set bg=dark                     " Makes items more readable

colorscheme molokai             " Change the colorscheme
" }}}

"  General Config {{{
set number                      " Line numbers are good

set ruler                       " Always show where you are in file

set backspace=indent,eol,start  " Allow backspace in insert mode

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

set modeline                    " Enable modelines in vim

set autochdir                   " Automatically cd into `dir %`

let g:clipbrdDefaultReg = '+'   " Default Clipboard Registry = +
let mapleader           = ','   " Map Leader is comma

" set list these characters
set listchars=tab:▸\ ,eol:¬
set listchars+=extends:❯,precedes:❮
set showbreak=↪\                " show when the line is wrapped
set linebreak                   " line wrap on words not characters

set synmaxcol=800               " don't highlight massive lines
set tags+=tags;                 " use tag files

set lazyredraw                  " lazily redraw the screen

" }}}

" Backups and Undos {{{
set backup                      " Enable backups
set backupdir=~/.vim/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,/var/tmp,/tmp

if has("persistent_undo")
    " Keep undo history across sessions, by storing in file.
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
set foldmethod=marker          " Fold based on marker
set foldnestmax=3              " Deepest fold is 3 levels
set nofoldenable               " Dont fold by default

set foldopen=block,hor,insert  " Which commands trigger autounfold
set foldopen+=jump,mark
set foldopen+=percent,search
set foldopen+=quickfix,tag,undo
" }}}

" Completion {{{
set wildmode=full
set wildmenu                            " C-n and C-p scroll through matches

"stuff to ignore when tab completing
set wildignore=*.o,*.obj                " object files
set wildignore+=*.class                 " Java class files
set wildignore+=*.pyc                   " python compiled files

set wildignore+=*vim/backups*           " anything from the backups folder
set wildignore+=*~,#*#,*.swp            " all other backup files

" tmp folder and log folders
set wildignore+=log/**
set wildignore+=tmp/**                  " anything that is temporary

" image files
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.bmp
" }}}

" Search Settings  {{{
set ignorecase                  " Ignore case when searching
set smartcase                   " Unless search has a capital word in it

set incsearch                   " Find the next match as we type the search

set hlsearch                    " Highlight searches by default
set wrapscan                    " Wrap search upon reaching the end of document

" }}}

" Highlight {{{

" Highlights trailing spaces with a red underline
highlight TrailSpace cterm=underline ctermfg=red gui=underline guifg=red
let TrailSpace = matchadd('TrailSpace' , '\s\+$')
autocmd ColorScheme * highlight TrailSpace cterm=underline ctermfg=red
autocmd ColorScheme * highlight TrailSpace gui=underline guifg=red

" Highlights lines over 80 chars,
highlight OverLine cterm=italic gui=italic ctermfg=red guifg=red
let OverLine = matchadd('OverLine', '\%>80v.\+')
autocmd ColorScheme * highlight OverLine cterm=italic ctermfg=red
autocmd ColorScheme * highlight OverLine gui=italic guifg=red
" }}}

" Plugins {{{
" ================== Buffergator
let g:buffergator_suppress_keymaps=1

" ================== NERDTree
nnoremap <leader><leader>e :NERDTreeToggle<CR>
let NERDTreeShowBookmarks               = 1
let NERDTreeChDirMode                   = 0
let NERDTreeQuitOnOpen                  = 1
let NERDTreeMouseMode                   = 2
let NERDTreeShowHidden                  = 1
let NERDTreeIgnore                      = ['\.pyc','\~$','\.swo$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab            = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

" ================= syntastic
let g:syntastic_check_on_open        = 1
let g:syntastic_error_symbol         = '✗'
let g:syntastic_style_error_symbol   = '★'
let g:syntastic_warning_symbol       = '⚠'
let g:syntastic_style_warning_symbol = '>'

"============== vim-powerline
if $TERM != 'linux' || has('gui_running')
    let g:Powerline_symbols = 'fancy'
endif

"let g:Powerline_symbols_override = { 'LINE' : 'L' }
let g:Powerline_stl_path_style = 'short'
let g:Powerline_colorsheme     = 'solarized16'

" Don't show current mode down the bottom
set noshowmode

" ================== snipmate
let g:snips_author="Prajjwal Bhandari"

" ================== Sideways
nnoremap <silent> <leader><leader>h :SidewaysLeft<CR>
nnoremap <silent> <leader><leader>l :SidewaysRight<CR>

" ================== UndoTree
nnoremap <silent> <leader><leader>u :UndotreeToggle<CR>

" ================== Tagbar
nnoremap <silent> <leader><leader>t :TagbarToggle<CR>

" ================== Ultisnips
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"

" ================== HaskellMode
let g:haddock_indexfiledir = "~/.vim/bundle/haskellmode-vim"
let g:haddock_browser      = "/usr/bin/firefox"
" }}}

" Filetypes {{{

" ================== Haskell
let g:ghc = "/usr/bin/ghc"
autocmd BufEnter *.hs compiler ghc
autocmd! FileType haskell set makeprg=ghc\ %

" ================== Latex
autocmd FileType tex setlocal spell textwidth=78

" ================== Markdown
autocmd FileType markdown setlocal spell textwidth=78

" Don't strip whitespace since it actually matters
autocmd FileType markdown let b:noStripWhitespace=1

" And don't whine about the 'newline' marker
autocmd FileType markdown call matchdelete(TrailSpace)
autocmd FileType markdown let TrailSpace = matchadd('TrailSpace','\s\s\zs\s\+$')

"  ================ CHANGELOG
autocmd BufRead,BufNewFile CHANGELOG setlocal filetype=changelog

" ================= Mail
autocmd FileType mail let b:noStripWhitespace=1
autocmd FileType mail setlocal spell textwidth=78

" ================= Perl
autocmd FileType perl setlocal keywordprg=perldoc\ -f

" }}}

" Remaps {{{
" Disable the Arrow keys {{{
inoremap <LEFT>  <NOP>
inoremap <RIGHT> <NOP>
inoremap <UP>    <NOP>
inoremap <DOWN>  <NOP>

noremap <LEFT>  <NOP>
noremap <RIGHT> <NOP>
noremap <UP>    <NOP>
noremap <DOWN>  <NOP>
"}}}

" Use the Black Hole Buffer {{{

" ,dX deletes a line without adding it to yank stack: normal and visual mode.
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d
nnoremap <silent> <leader>D "_D
vnoremap <silent> <leader>D "_D

" ,cX changes a line without adding it to yank stack: normal and visual mode.
nnoremap <silent> <leader>c "_c
vnoremap <silent> <leader>c "_c
nnoremap <silent> <leader>C "_C
vnoremap <silent> <leader>C "_C
"}}}

" Easy precision
nnoremap ' `
nnoremap ` '

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Show whitespaces
nnoremap <silent> <leader>s :set nolist!<CR>

" Clear highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Quick write read only Files
cnoremap w!! w !sudo tee % >/dev/null

" Y works the same as C, and D
nnoremap Y y$

" Switch between absolute and relative line numbers
inoremap <silent> <leader><leader>n <C-o>:set relativenumber!<CR>
nnoremap <silent> <leader><leader>n <ESC>:set relativenumber!<CR>

" quick and easy make
inoremap <leader>mk <C-o>:make<CR>
nnoremap <leader>mk :make<CR>

" quick esacpes
inoremap qq <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" Help key is not helpful
noremap  <F1> <ESC>
noremap! <F1> <ESC>

" }}}

" Functions {{{
" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
    if exists('b:noStripWhitespace')
        return
    endif
    call RemoveWhiteSpaceForce()
endfunction

function! RemoveWhiteSpaceForce()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal 'z"
endfunction
" }}}

" Misc Autocmds {{{

" Read template files if they exist
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.skel

" Hop out of insertmode after 5 seconds of inactivity
autocmd CursorHoldI * stopinsert
autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=5000
autocmd InsertLeave * let &updatetime=updaterestore

" Remove whitespace before writing to any file
autocmd BufWrite,FileWritePre * call RemoveWhiteSpace()

" Don't whine about long lines when I'm golfing please
autocmd BufEnter *golf* call matchdelete(OverLine)
" }}}

" OVERRIDES {{{
autocmd BufEnter * set cmdheight=1

" Source local vimrc if it exists
if filereadable($HOME . "/.vimrc.local")
    source $HOME/.vimrc.local
endif
" }}}

" vim:foldenable
