setlocal spell
setlocal textwidth=78
command! -count=0 -nargs=0 WC <count>,$w !detex | wc -w
command! -range=% -nargs=0 WC <line1>,<line2>w !detex | wc -w

let b:tex_flavor = 'pdflatex'
compiler tex
set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode\ %
set errorformat=%f:%l:\ %m
