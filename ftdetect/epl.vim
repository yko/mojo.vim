au! BufRead,BufNewFile *.html.epl set filetype=html.epl
au! BufRead,BufNewFile *.html.ep  set filetype=html.epl

" Auto-highlight templates in __DATA__
if (exists("mojo_highlight_data"))
    autocmd FileType perl syn include @perlDATA syntax/MojoliciousLite.vim
endif
