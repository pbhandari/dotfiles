setlocal spell
setlocal textwidth=78

" Don't strip whitespace since it actually matters
let b:noStripWhitespace=1

" And don't whine about the 'newline' marker
call matchdelete(TrailSpace)
let TrailSpace = matchadd('TrailSpace','\s\s\zs\s\+$')

" Show listchars since EOL is pretty useful here
setlocal list

" TODO: modify this so that new line markers are only shown on lines with 2 or
" more spaces
