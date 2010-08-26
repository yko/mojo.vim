" html w/ Perl as a preprocessor
" Language:    Perl + html
" Maintainer:  yko <ykorshak@gmail.com>
" Version:     0.0.5
" Last Change: 2010 Aug 26
" Location:    http://github.com/yko/Vim-Mojo-Data-syntax
" Original version: vti <vti@cpan.org>

if version < 600
syntax clear
elseif exists("b:current_syntax")
finish
endif

if !exists("main_syntax")
    let main_syntax = 'perlscript'
endif

if exists("perl_fold") 
   let bfold = perl_fold
    unlet perl_fold
endif

if version < 600
  so <sfile>:p:h/html.vim
  syn include @Perl <sfile>:p:h/perl.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
  syn include @Perl syntax/perl.vim
endif

syn cluster htmlPreproc add=PerlInside

syn match MojoStart "<%" contained 
syn match MojoStart "<%=" contained 
syn match MojoStart "<%==" contained 
syn match MojoStart "<%{=" contained 
syn match MojoStart "^%"  contained 
syn match MojoStart "^%="  contained 
syn match MojoStart "^%=="  contained 
syn match MojoEnd "%>" contained 
syn match MojoEnd "=%>" contained 

syn cluster Mojo contains=MojoStart,MojoEnd

syn region  PerlInside keepend oneline start=+<%=\?+hs=s skip=+".*%>.*"+ end=+%>+ contains=@Mojo,@Perl
syn region  PerlInside keepend oneline start=+^%=\?+hs=s end=+$+ contains=@Mojo,@Perl


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

