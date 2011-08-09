" Vim syntax file (for including only)
" html w/ Perl as a preprocessor in __DATA__
" Language:    Mojo epl templates stored in Perl __DATA__
" Maintainer:  yko <yko@cpan.org>
" Version:     0.04
" Last Change: 2011 Aug 09
" Location:    http://github.com/yko/mojo.vim
"
" Thanks to Viacheslav Tykhanovskyi for simplified region syntax
"
" Possible configuration:
"
"  let mojo_highlight_data = 1
"  let mojo_disable_html = 1
"
" For highlight templates in __DATA__ add following line to your .vimrc:
" let mojo_highlight_data = 1

if !exists("mojo_highlight_data")
    finish
endif

if !exists("b:current_syntax")
  echoerr "MojolisiousTemplate can only be included in existing syntax"
  finish
endif

" Store current syntax name
let cs = b:current_syntax
unlet b:current_syntax

if !exists("mojo_disable_html")
  unlet! b:current_syntax
  syn include @Html syntax/html.vim
endif

syntax include @Epl syntax/epl.vim

" Set up hl of filename headers
syn match MojoFileNameStart "@@" contained

syn region MojoFileContainer start=/@@/ end=/^__END__\|@@/me=s-1 contains=@Epl,@Html,MojoFileName contained keepend fold
syn region MojoFileName start=/@@/ end="$" keepend contains=MojoFileNameStart contained keepend

" Push Template sections and HTML syntax into @perlDATA cluster
syn cluster perlDATA add=@Html,MojoFileContainer

" Revert current syntax name
let b:current_syntax = cs
