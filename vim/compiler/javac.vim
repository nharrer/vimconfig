" Vim compiler file
" Compiler:     javac
" Maintainer:   Doug Kearns <djkea2@mugca.its.monash.edu.au>
" URL:		http://mugca.its.monash.edu.au/~djkea2/vim/compiler/javac.vim
" Last Change:  2004 Apr 15

if exists("current_compiler")
  finish
endif
let current_compiler = "javac"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=C:/Progra~2/JDK1.8/bin/javac.exe\ -classpath\ J:\lib\softline16.jar;J:\\;J:\Kunde\Driver\ \ %

" if exists("%PROGRAMFILES(x86)%\JDK1.8")
" CompilerSet makeprg="'%PROGRAMFILES(x86)%'"/JDK1.8/bin/javac.exe\ -classpath\ J:\lib\softline16.jar;J:\\;J:\Kunde\Driver\ \ %
" elsif
" CompilerSet makeprg="%PROGRAMFILES%"/JDK1.8/bin/javac.exe\ -classpath\ J:\lib\softline16.jar;J:\\;J:\Kunde\Driver\ \ %
" endif

"CompilerSet errorformat=%E%f:%l:\ %m,%-Z%p^,%-C%.%#,%-G%.%#
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%Csymbol\ \ :\ %m,%-C%.%# 