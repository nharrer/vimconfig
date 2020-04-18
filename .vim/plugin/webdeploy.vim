" Hilfscript für Package-Template für Softline Web-Deploy

command! DeployCleanCVSPaths call DeployCleanCVSPaths()
command! DeployTransformToBuild call DeployTransformToBuild()
command! Deploy call DeployDoAll()


function DeployCleanCVSPaths()
    call s:ExecNoError('%s_^\w\{-};__g')    
    call s:ExecNoError('%s_;\s*Ticket \d.*__g')
endfunction

function DeployTransformToBuild()
    call s:ExecNoError('%s_/web/_/build/web/_g')
    call s:ExecNoError('%s_src/java_build/web/WEB-INF/classes_g')
    call s:ExecNoError('%s_\.java_*.class_g')
endfunction

function DeployDoAll()
    " remove empty lines
    g/^\s*$/d

    " clear register b and move all lines starting with # into it
    normal qbq
    g/^#.*/d B

    " remove trash
    call DeployCleanCVSPaths()
    sort

    " copy all into register a
    %y a

    call DeployTransformToBuild()

    " insert empty line at beginning
    exe "normal ggO\e"

    " paste original on top
    0pu a
    exe "normal ggO\e"

    " paste comments on top        
    0pu b
    normal ggdd
endfunction

" Damit die bloeden "Pattern not found" Exceptions weg sind.
" Das geht sicher irgenwie besser, aber keine Ahnung wie
function! s:ExecNoError(expr)
    try
      exe a:expr
    catch 
      " ignore
    endtry 
endfunction

