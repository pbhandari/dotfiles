setlocal spell
setlocal textwidth=78

" Don't strip whitespace since it actually matters
let b:keep_whitespace = 1

" A trailing double-space is a markdown hard line break, so only flag 3+
" trailing spaces. ApplyTrailSpace() (defined in ~/.vimrc) reads this pattern.
let b:trailspace_pattern = '\s\s\zs\s\+$'
if exists('*ApplyTrailSpace')
    call ApplyTrailSpace()
endif

" Show listchars since EOL is pretty useful here
setlocal list
