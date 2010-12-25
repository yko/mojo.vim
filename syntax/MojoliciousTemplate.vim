" Vim syntax file (for including only)
" html w/ Perl as a preprocessor in __DATA__
" Language:    Mojo epl templates stored in Perl __DATA__
" Maintainer:  yko <ykorshak@gmail.com>
" Version:     0.03
" Last Change: 2010 Dec 25
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

if !exists("b:current_syntax")
  echoerr "MojolisiousTemplate can only be included in existing syntax"
  finish
endif

" Store current syntax name
let cs = b:current_syntax
unlet b:current_syntax

syntax include @Epl syntax/epl.vim

if !exists("mojo_disable_html")
  unlet! b:current_syntax
  syn include @Html syntax/html.vim
endif

" Set up hl of filename headers
syn match MojoFileNameStart "@@" contained

syn region MojoFileContainer start=/@@/ end=/@@/me=s-1 contains=@Epl,@Html,MojoFileName keepend fold
syn region MojoFileName start=/@@/ end="$" keepend contains=MojoFileNameStart contained keepend

" Revert current syntax name
let b:current_syntax = cs
