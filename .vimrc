set nocompatible                " Revert all settings back to vim default

" Infect all the things
execute pathogen#infect('bundle/{}')

" ================= General Config ===================
set bg=dark                     " Makes items more readable
set number                      " Line numbers are good
set ruler                       " Always show where you are in file

set backspace=indent,eol,start  " Allow backspace in insert mode
set listchars=tab:>-,trail:·,eol:$ " Catch trailing whitespaces

set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set laststatus=2                " Always show the statusbar
set cmdheight=1                 " Set the height of the command line
set showtabline=2               " Always show tab-bar
set cursorline                  " Highlight current line

set visualbell                  " No sounds

set pastetoggle=<F2>            " Enter paste-mode when F2
set autoread                    " Reload files changed outside vim
set autowrite                   " Write to file when changing buffers
set hidden                      " Buffers exist in the background

set scrolloff=3                 " Start scrolling 3 lines before buffer ends
set sidescrolloff=3             " Start scrolling 3 lines before buffer ends
set virtualedit=onemore         " Allow for cursor beyond last character
set viminfo='100,f1             " Save up to 100 marks, enable capital marks

set history=1000                " Store lots of :cmdline history
set nrformats-=octal            " Look up :h nrformat
set encoding=utf-8

let g:clipbrdDefaultReg = '+'   "Default Clipboard Registry = +
let mapleader = ','


runtime macros/matchit.vim      " Better open/close matching

syntax on                       " Turn on Syntax hilighting
filetype on                     " Turn on filetype checking
filetype plugin on
filetype indent on


" =================== Colour =========================
" Highlights lines over 80 chars,
highlight OverLine cterm=bold ctermbg=None ctermfg=red
match OverLine /\%81v.\+/

" make sure that colorschemes don't overwrite this
autocmd ColorScheme * highlight OverLine cterm=bold ctermbg=None ctermfg=red

colorscheme solarized           " Better colouring

" ================= Change Storage ===================
set backup                      " Enable backups
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

if has("persistent_undo")
    " Keep undo history across sessions, by storing in file.
    " Only works all the time.
    set undodir=~/.vim/backups
    set undofile
endif

" ============== General Plugin Config ===============

" ================== NERDTree
nnoremap <leader><leader>e :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" ================= syntastic
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'

"============== vim-powerline
if $DISPLAY != "" && $TERM !="rxvt-unicode-256color"
    let g:Powerline_symbols = 'fancy'
endif

let g:Powerline_symbols_override = {
            \ 'LINE' : 'L',
            \ }
let g:Powerline_stl_path_style='short'
"let g:Powerline_theme = 'solarized256'

" ================== snipmate
let g:snips_author="Prajjwal Bhandari"

" ================= solarized
if (g:colors_name == "solarized")
    if !has('gui_running')
        let g:solarized_termcolors=&t_Co
        let g:solarized_termtrans=1
     endif
    let g:solarized_contrast="high"
    " Now Fix solarized annoyances
    highlight Normal        ctermbg=None

    highlight CursorLine    ctermbg=black  " 8 works better than darkgray
    highlight CursorLineNr  ctermbg=black ctermfg=darkblue
    highlight LineNr        ctermbg=None

    highlight TabLine       ctermfg=darkblue ctermbg=None
    highlight TabLineSel    ctermfg=darkblue ctermbg=None
    highlight TabLineFill   ctermbg=None
endif

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

" ================ Completion ========================
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

" =================== indentation ====================
set autoindent                  " Autoindent by default
set copyindent                  " Use indent format of prev line, if autoindent

set tabstop=4                   " Show tabs as 4 spaces
set shiftwidth=4                " Tab goes forward 4 spaces
set softtabstop=4               " Virtual tab stop is also 4

set shiftround                  " Round tabulation to a multiple of /shiftwidth/
set expandtab                   " All tabs are spaces

" ================== folds ===========================
set foldmethod=indent          " Fold based on indent
set foldnestmax=3              " Deepest fold is 3 levels
set nofoldenable               " Dont fold by default

" ================ Search Settings  =================
set ignorecase                  " Ignore case when searching
set smartcase                   " Unless search has a capital word in it

set incsearch                   " Find the next match as we type the search

set hlsearch                    " Highlight searches by default
set wrapscan                    " Wrap search upon reaching the end of document

" ==================== Remaps ========================
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
            \ :exec "set " .((&number == 1)? "relativenumber" : "number")<CR>


"remove whitespace before writing to any file
autocmd! BufWrite,FileWritePre * call RemoveWhiteSpace()
autocmd Filetype java,c,h,cpp,hpp set cindent

" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
    :%s/\s*$//g
    :'^
    "`.
endfunction

