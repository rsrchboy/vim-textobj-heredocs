" vim-textobj plugin to handle heredocs.
"
" NOTE FIXME this might be somewhat Perl-specific?

" second submatch is the token; e.g. 'EOF' or 'SQL'
if !has_key(g:, 'textobj#user#plugin#heredocs#start_pattern')
    let g:textobj#user#plugin#heredocs#start_pattern = '<<\~\?\([''"]\?\)\(\u\+\)\1\?'
endif

function! textobj#user#plugin#heredocs#A() abort
    return s:FindBlock(0)
endfunction

function! textobj#user#plugin#heredocs#I() abort
    return s:FindBlock(1)
endfunction

function! s:FindBlock(offset) abort
    let l:current_line = line('.')

    " TODO handle failure modes...?

    let l:start_line = search(g:textobj#user#plugin#heredocs#start_pattern, 'bcn', 1)
    if !l:start_line
        return 0
    endif

    let l:token = substitute(
        \ getline(l:start_line),
        \ '^.*'.g:textobj#user#plugin#heredocs#start_pattern.'.*$',
        \ '\=submatch(2)', '')
    echom 'token is: ' . l:token

    " Never select the first line, as it's liable to have a bunch of other
    " gunk on it
    let l:start_line += 1
    let l:end_line    = search('^\s*'.l:token.'$', 'cnW') - a:offset

    return [ 'V', [0, l:start_line, 0], [0, l:end_line, 0] ]
endfunction

" __END__
