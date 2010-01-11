" Vim syntax file (for include only)
" Language:    Mojo epl templats stored in  Perl __DATA__ 
" By Yaroslav Korhsak <ykorshak@gmail.com>
"
" Thanks to Viacheslav Tykhanovskyi for simplified region syntax
"
" possible configuration:
"  let mojo_disable_html = 1
"
" For highligh templates in __DATA__, 
" save this file into ~/.vim/syntax and add following line to your .vimrc:
" autocmd FileType perl syn include @perlDATA syntax/MojoTemplate.vim

if !exists("b:current_syntax")
  echoerr "MojolisiousTemplate can only be included in existing syntax"
  echoerr "Example: autocmd FileType perl syn include @perlDATA syntax/MojoTemplate.vim"
  finish
endif

let cs = b:current_syntax 
unlet b:current_syntax

let pf= perl_fold
unlet perl_fold

syntax include @Perl syntax/perl.vim

let perl_fold=pf

if !exists("mojo_disable_html")
  unlet b:current_syntax
  syn include @Html syntax/html.vim
endif

syn match MojoStart "<%" contained 
syn match MojoStart "<%=" contained 
syn match MojoStart "<%==" contained 
syn match MojoStart "<%{=" contained 
syn match MojoStart "^%"  contained 
syn match MojoStart "^%="  contained 
syn match MojoEnd "%>" contained 

syn match MojoFileNameStart "@@" contained
syn cluster Mojo contains=MojoStart,MojoEnd

syn region MojoFileContainer start=/@@/ end=/@@/me=s-1 contains=MojoPerlCode,@Html,MojoFileName keepend  fold
syn region MojoFileName start=/@@/ end="$" keepend contains=MojoFileNameStart contained keepend
syntax region MojoPerlCode start="<%=\?"hs=e+1 end="%>"hs=s-1 contains=@Perl,@Mojo oneline contained keepend
syntax region MojoPerlCode start="^%=\?"hs=e+1 end="$" contains=@Perl,@Mojo oneline contained keepend

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
