" html w/ Perl as a preprocessor
" Language:    Perl + html
" Maintainer:  yko <ykorshak@gmail.com>
" version:     0.04
" Last Change: 2010 Dec 26
" Location:    http://github.com/yko/mojo.vim
" Original version: vti <vti@cpan.org>

if exists("perl_fold")
   let b:bfold = perl_fold
   unlet perl_fold
endif

" Clear previous syntax name
unlet! b:current_syntax

" Include Perl syntax intp @Perl cluster
syntax include @Perl syntax/perl.vim

" This groups are broken when included
syn cluster Perl remove=perlFunctionName,perlElseIfError

if exists("b:bfold")
    perl_fold = b:bfold
    unlet b:bfold
endif

" Begin and end of code blocks
syn match MojoStart /<%=\{0,2}/ contained
syn match MojoStart /^\s*%=\{0,2}/  contained
syn match MojoEnd /=\{0,1}%>/ contained

syn cluster Mojo contains=MojoStart,MojoEnd

" Highlight code blocks
syn region PerlInside keepend oneline start=+<%=\{0,2}+hs=s skip=+".*%>.*"+ end=+=\{0,1}%>+ contains=@Mojo,@Perl
syn region PerlInside keepend oneline start=+^\s*%=\{0,2}+hs=s end=+$+ contains=@Mojo,@Perl

" Display code blocks in tag parameters' quoted value like 
" <a href="<%= url_for 'foo' %>'>
syn cluster htmlPreproc add=PerlInside

command -nargs=+ HiLink hi def link <args>

HiLink MojoStart perlType
HiLink MojoEnd perlType
HiLink MojoFileName perlString
HiLink MojoFileNameStart perlSpecial

delcommand HiLink

let b:current_syntax = "html.epl"
