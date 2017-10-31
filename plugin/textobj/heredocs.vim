" vim-textobj plugin to handle heredocs.
"
" Chris Weyl <cweyl@alumni.drew.edu> 2017

if exists('g:loaded_textobj_heredocs')
    finish
endif
let g:loaded_textobj_heredocs = 1

call textobj#user#plugin('heredocs', {
            \   '-': {
            \       'select-a-function': 'textobj#user#plugin#heredocs#A',
            \       'select-i-function': 'textobj#user#plugin#heredocs#I',
            \       'select-a': 'aH',
            \       'select-i': 'iH',
            \   },
            \})

" __END__
