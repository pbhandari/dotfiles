command! -count=0 -nargs=0 WC <count>,$w !detex | wc -w
command! -range=% -nargs=0 WC <line1>,<line2>w !detex | wc -w
