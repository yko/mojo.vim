" html w/ Perl as a preprocessor
" Language:    Perl + html
" Maintainer:  yko <ykorshak@gmail.com>
" version:     0.02_2
" Last Change: 2010 Dec 25
" Location:    http://github.com/yko/mojo.vim
" Original version: vti <vti@cpan.org>

"if version < 600
"syntax clear
"elseif exists("b:current_syntax")
"finish
"endif

if !exists("main_syntax")
    let main_syntax = 'perlscript'
endif

if exists("perl_fold") 
   let bfold = perl_fold
   unlet perl_fold
endif

if version < 600
  syn include @Perl <sfile>:p:h/perl.vim
else
  unlet! b:current_syntax
  syn include @Perl syntax/perl.vim
endif

syn match MojoStart /<%=\{0,2}/ contained 
syn match MojoStart /^\s*%=\{0,2}/  contained 
syn match MojoEnd /=\{0,1}%>/ contained 

syn cluster Mojo contains=MojoStart,MojoEnd

syn region PerlInside keepend oneline start=+<%=\{0,2}+hs=s skip=+".*%>.*"+ end=+=\{0,1}%>+ contains=@Mojo,@Perl
syn region PerlInside keepend oneline start=+^\s*%=\{0,2}+hs=s end=+$+ contains=@Mojo,@Perl

if version >= 508 || !exists("did_epl_syn_inits")
  if version < 508
    let did_epl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink MojoStart perlType
  HiLink MojoEnd perlType

  delcommand HiLink
endif

let b:current_syntax = "epl"

if exists("bfold") 
    perl_fold = bfold
    unlet bfold
endif
