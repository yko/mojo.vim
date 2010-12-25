" Vim syntax file (for including only)
" html w/ Perl as a preprocessor in __DATA__
" Language:    Mojo epl templates stored in Perl __DATA__ 
" Maintainer:  yko <ykorshak@gmail.com>
" Version:     0.02_2
" Last Change: 2010 Dec 25
" Location:    http://github.com/yko/mojo.vim
"
" Thanks to Viacheslav Tykhanovskyi for simplified region syntax
"
" Possible configuration:
"  let mojo_disable_html = 1
"
" For highlight templates in __DATA__, 
" save this file into ~/.vim/syntax and add following line to your .vimrc:
" autocmd FileType perl syn include @perlDATA syntax/MojoliciousTemplate.vim

if !exists("b:current_syntax")
  echoerr "MojolisiousTemplate can only be included in existing syntax"
  echoerr "Example: autocmd FileType perl syn include @perlDATA syntax/MojoliciousTemplate.vim"
  finish
endif

let cs = b:current_syntax 
unlet b:current_syntax

if exists("perl_fold") 
   let bfold = perl_fold
   unlet perl_fold
endif

syntax include @Perl syntax/perl.vim

if exists("bfold") 
    perl_fold = bfold
    unlet bfold
endif

if !exists("mojo_disable_html")
  unlet! b:current_syntax
  syn include @Html syntax/html.vim
endif

syn match MojoStart /<%=\{0,2}/ contained 
syn match MojoStart /^\s*%=\{0,2}/  contained 
syn match MojoEnd /=\{0,1}%>/ contained 

syn match MojoFileNameStart "@@" contained
syn cluster Mojo contains=MojoStart,MojoEnd

syn region MojoFileContainer start=/@@/ end=/@@/me=s-1 contains=MojoPerlCode,@Html,MojoFileName keepend  fold
syn region MojoFileName start=/@@/ end="$" keepend contains=MojoFileNameStart contained keepend
syn region MojoPerlCode keepend oneline contained start=+<%=\{0,2}+hs=s skip=+".*%>.*"+ end=+=\{0,1}%>+ contains=@Mojo,@Perl
syn region MojoPerlCode keepend oneline contained start=+^\s*%=\{0,2}+hs=s end=+$+ contains=@Mojo,@Perl

" Displaying MojoPerlCode in quotes and double-cuotes
" Thanx to Aaron Hope, aspperl.vim maintainer
syn cluster htmlPreproc add=MojoPerlCode

if version >= 508 || !exists("did_a65_syntax_inits")
  if version < 508
    let did_a65_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink MojoGetContainer  perlType
  HiLink TFileName perlType
  HiLink MojoStart perlType
  HiLink MojoEnd perlType
  HiLink MojoFileName perlString
  HiLink MojoFileNameStart perlSpecial
  delcommand HiLink
endif

let b:current_syntax = cs
