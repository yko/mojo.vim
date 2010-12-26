au! BufRead,BufNewFile *.html.epl set filetype=html.epl
au! BufRead,BufNewFile *.html.ep  set filetype=html.epl

" Auto-highlight templates in __DATA__
au! FileType perl au Syntax <buffer> call LoadMojoliciousLite(exists("mojo_highlight_data"))

fu LoadMojoliciousLite(ex)
    if a:ex
        syn include @perlDATA syntax/MojoliciousLite.vim
    endif
endfu
