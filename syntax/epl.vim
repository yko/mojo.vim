" html w/ Perl as a preprocessor
" Language:    Perl + html
" Maintainer:  yko <ykorshak@gmail.com>
" version:     0.04
" Last Change: 2011 May 12
" Location:    http://github.com/yko/mojo.vim
" License:     Artistic 2.0
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
syn cluster Perl remove=perlFunctionName,perlElseIfError,perlBraces

if exists("b:bfold")
    let perl_fold = b:bfold
    unlet b:bfold
endif

" Begin and end of code blocks
syn cluster Mojo contains=MojoStart,MojoEnd

" Highlight code blocks
syn region PerlInside keepend matchgroup=MojoStart start=+<%=\{0,2}+ matchgroup=MojoEnd end=+=\{0,1}%>+ contains=@Perl
syn region PerlInside keepend matchgroup=MojoSingleStart start=+^\s*%=\{0,2}+ end=+$+ contains=@Perl

if !exists("mojo_no_helpers")

    " Default helpers
    syn match perlStatementFiledesc  "\<\%(app\|content\|content_for\|dumper\|extends\|flash\|include\|layout\|memorize\|param\|session\|stash\|url_for\|title\)\>" nextgroup=perlGenericBlock skipwhite contained

    " Tag helpers
    syn match perlStatementFiledesc "\<\%(base_tag\|check_box\|file_field\|form_for\|hidden_field\|input_tag\|javascript\|link_to\|password_field\|radio_button\|select_field\|stylesheet\|submit_button\|tag\|text_area\|text_field\)\>" nextgroup=perlGenericBlock skipwhite contained

    " JavaScript
    syn region javaScript start="<%=\{1,2}\s\+javascript\s\+.*begin\s\+%>" end="<%\s\+end\s\+=\{0,1}%>" contains=@htmlJavaScript,PerlInside transparent keepend
    syn region javaScript start="\s*%=\{1,2}\s\+javascript\s\+.*begin\s*$" end="%\s\+end" contains=@htmlJavaScript,PerlInside transparent keepend

    " Style
    syn region CSS start="<%=\{1,2}\s\+stylesheet\s\+.*begin\s\+%>" end="<%\s\+end\s\+=\{0,1}%>" contains=@htmlCss,PerlInside transparent keepend
    syn region CSS start="%=\{1,2}\s\+stylesheet\s\+.*begin\s*$" end="%\s\+end" contains=@htmlCss,PerlInside transparent keepend

endif

" Display code blocks in tag parameters' quoted value like 
" <a href="<%= url_for 'foo' %>'>
syn cluster htmlPreproc add=PerlInside

command -nargs=+ HiLink hi def link <args>

HiLink MojoStart                perlType
HiLink MojoSingleStart          perlType
HiLink MojoEnd                  perlType
HiLink MojoFileName             perlString
HiLink MojoFileNameStart        perlSpecial
HiLink MojoError                Error

delcommand HiLink

let b:current_syntax = "html.epl"
