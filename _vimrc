" .vimrc

" General Behaviour {{{
" Infect all the things
execute pathogen#infect('bundle/{}')
runtime macros/matchit.vim      " Better open/close matching

set nocompatible                " Revert all settings back to vim default

set visualbell                  " No sounds
set noerrorbells                " Don't beep

set backspace=indent,eol,start  " Allow backspace in insert mode

set pastetoggle=<F2>            " Enter paste-mode when F2
set autoread                    " Reload files changed outside vim
set autowrite                   " Write to file when changing buffers
set hidden                      " Buffers exist in the background
set switchbuf=useopen           " Use already open buffers if available

set linebreak                   " line wrap on words not characters
set nowrap                      " don't wrap lines in vim.

set viminfo='100,f1             " Save up to 100 marks, enable capital marks

set history=1000                " Store lots of :cmdline history
set nrformats-=octal            " Look up :h nrformat

set modeline                    " Enable modelines in vim

set autochdir                   " Automatically cd into `dir %`

let g:clipbrdDefaultReg = '*'   " Default Clipboard Registry = *
let mapleader           = ' '   " Map Leader is space
let maplocalleader      = ','   " Local Map Leader is comma

set report=0                    " Always report how many lines were changed

set tags+=tags;                 " Use tag files

set splitbelow                  " New windows start below old ones
set splitright                  " New windows start to the right of old ones

set tildeop                     " Tilde no longer only works on only one char
" }}}

"  Appearance {{{
set bg=dark                     " Makes items more readable

set number                      " Line numbers are good
set relativenumber              " Relative numbers are better

set showcmd                     " Show incomplete cmds down the bottom
set cmdheight=1                 " Always show the command line

set cursorline                  " Highlight current line
set ruler                       " Always show where you are in file
set laststatus=2                " Always show the statusbar
set showtabline=1               " Show tab-bar only if there are tabs

set scrolloff=3                 " Start scroll 3 lines before vert buffer ends
set sidescrolloff=3             " Start scroll 3 lines before horz buffer ends

set virtualedit=onemore         " Allow for cursor beyond last character

set listchars=tab:▸\ ,eol:¬
set listchars+=extends:❯,precedes:❮

set showbreak=↪\                " show when the line is wrapped
set synmaxcol=800               " don't highlight massive lines

set lazyredraw                  " lazily redraw the screen

let g:rehash256 = 1
colorscheme molokai

syntax on                       " Turn on Syntax hilighting
filetype on                     " Turn on filetype checking
filetype plugin on
filetype indent on
" }}}

" Backups and Undos {{{
" set backup                      " Enable backups
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
set completeopt=longest,menuone

set wildmenu                            " C-n and C-p scroll through matches
set wildmode=longest:full,full          " Show completions on first <TAB> and
                                        " start cycling through on second <TAB>

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

" Plugins {{{
" ================= syntastic
let g:syntastic_check_on_open            = 1
let g:syntastic_error_symbol             = '✗'
let g:syntastic_style_error_symbol       = '★'
let g:syntastic_warning_symbol           = '⚠'
let g:syntastic_style_warning_symbol     = '>'
let g:syntastic_always_populate_loc_list = 1

"============== vim-airline

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep         = '⮀'
let g:airline_left_alt_sep     = '⮁'
let g:airline_right_sep        = '⮂'
let g:airline_right_alt_sep    = '⮃'
let g:airline_symbols.branch   = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr   = '⮃ ⭡'
let g:airline_symbols.paste    = 'paste'

let g:airline#extensions#whitespace#checks = [ 'indent' ]

" Don't show current mode down the bottom
set noshowmode

" ================== snipmate
let g:snips_author="Prajjwal Bhandari"

" ================== UndoTree
nnoremap <silent> <leader><leader>u :UndotreeToggle<CR>

" ================== Tagbar
nnoremap <silent> <leader><leader>t :TagbarToggle<CR>

" ================== HaskellMode
let g:haddock_indexfiledir = "~/.vim/bundle/haskellmode-vim"
let g:haddock_browser      = "/usr/bin/firefox"
" }}}

" Highlight {{{
" Highlights lines over 80 chars,
highlight ColorColumn cterm=bold ctermbg=161   ctermfg=white
highlight ColorColumn gui=bold   guifg=#ff0000 guibg=white
call matchadd('ColorColumn', '\%81v.', 100)
autocmd ColorScheme * highlight ColorColumn cterm=bold ctermbg=161 ctermfg=white
autocmd ColorScheme * highlight ColorColumn gui=bold guifg=#ff0000 guibg=white

" Highlights trailing spaces with a red underline
highlight TrailSpace cterm=underline ctermfg=red gui=underline guifg=red
let TrailSpace = matchadd('TrailSpace' , '\s\+$')
autocmd ColorScheme * highlight TrailSpace cterm=underline ctermfg=red
autocmd ColorScheme * highlight TrailSpace gui=underline guifg=red


" Add more items to the Todo group
highlight link myTodo Todo
autocmd Syntax * syntax keyword myTodo containedin=.*Comment
                 \ contained WARNING NOTE
" }}}

" Remaps {{{
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

" Disable Arrow keys. {{{
noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <LEFT> <NOP>
noremap <RIGHT> <NOP>
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHT> <NOP>
" }}}

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

" quick and easy make
nnoremap <leader>mk :make<CR>

" quick esacpes
noremap  qq <NOP>
inoremap qq <ESC>
vnoremap qq <ESC>

" Help key is not helpful
noremap  <F1> <ESC>
noremap! <F1> <ESC>

" Easier entry to commmand-mode
noremap ; :

" These are pretty handy.
noremap <BSLASH> ;
noremap <BAR> ,

" <BAR> is pretty handy too.
noremap g<BAR> <BAR>

" sometimes help needs to be vsplit
cnoremap vh     vert help
cnoremap vhelp  vert help

" quickly manage buffers
nnoremap <Leader>b :ls<CR>:b
nnoremap <Leader>B :ls!<CR>:b
" }}}

" Functions {{{
" Removes superfluous white space from the end of a line
let b:keep_whitespace = 0
function! RemoveWhiteSpace()
    if exists('b:keep_whitespace') && b:keep_whitespace
        return
    endif

    exe "normal mz"
    %s/\s\+$//ge
    exe "normal 'z"
endfunction
" }}}

" Misc Autocmds {{{
" Switch between relative and absolute numbering
augroup RELNUMBER
    autocmd!
    autocmd InsertEnter * setlocal norelativenumber
    autocmd InsertLeave * setlocal relativenumber
augroup END

" No need to highlight history files
augroup DISABLE_FILETYPES
    autocmd!
    autocmd BufRead *sh_history setlocal syntax off
augroup END

" Read template files if they exist
augroup READ_TEMPLATES
    autocmd!
    autocmd BufNewFile * silent! exe "0r ~/.vim/templates/" . &ft  . ".skel"
augroup END

" Hop out of insertmode after seconds of inactivity
augroup LEAVE_INSERT
    autocmd!
    autocmd CursorHoldI * stopinsert
    autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=5000
    autocmd InsertLeave * let &updatetime=updaterestore
augroup END

" Remove whitespace before writing to any file
augroup REMOVE_WHITESPACE
    autocmd!
    autocmd BufWrite,FileWritePre * call RemoveWhiteSpace()
augroup END
" }}}

" Source local vimrc if it exists
if filereadable($HOME . "/.vimrc.local")
    source $HOME/.vimrc.local
endif
" vim:foldenable
