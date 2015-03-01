setlocal cinoptions+=t0
setlocal cinoptions+=g1

let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options='-std=c++14'
syn match cppAccess "^\s*\<\(public\|protected\|private\)\>\ze:"
