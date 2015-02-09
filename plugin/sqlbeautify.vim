" Beautify SQL the Softline-Way

nmap <C-S-f> :call SQLBeautify()

nmap <C-S-d> ::%s_^\(.*\)$_"\1" +_g

function SQLBeautify()
  " damit das Syntax-Highlighting funktioniert
  set filetype=sql
  " SQLSetType sqlinformix
  " syntax on

  " mit -- kann ich hier nicht gut umgehen -> in {} ersetzen
  call ExecNoError('%s_--\(.*\)$_{ \1 }_g')
  call ExecNoError('%s_(_ (_g')

  " zuerst alles in eine Zeile wurschteln
  go 1
  %j
 
  " bei den wichtigen Keywords umbrechen
  call ExecNoError('%s_\s\+_ _g')
  call ExecNoError('%s_\<SELECT\>_SELECT_gi')
  call ExecNoError('%s_\([^(]\)\sSELECT\>_\1SELECT_gi')
  call ExecNoError('%s_\sINSERT\>_INSERT_gi')
  call ExecNoError('%s_\sUPDATE\>_UPDATE_gi')
  call ExecNoError('%s_\sFROM\>_  FROM_gi')
  call ExecNoError('%s_\s\<RIGHT\s\+OUTER\s\+JOIN\>_       RIGHT OUTER JOIN_gi')
  call ExecNoError('%s_\s\<LEFT\s\+OUTER\s\+JOIN\>_       LEFT OUTER JOIN_gi')
  call ExecNoError('%s_\s\<INNER\s\+JOIN\>_       INNER JOIN_gi')
  call ExecNoError('%s_\s\<CROSS\s\+JOIN\>_       CROSS JOIN_gi')
  " alles ausser OUTER|INNER|CROSS JOIN
  call ExecNoError('%s_\(\(OUTER\|INNER\|CROSS\)\s\+\)\@<!JOIN\>_\1       JOIN_gi')
  call ExecNoError('%s_\sSET\>_   SET_gi')
  call ExecNoError('%s_\sGROUP\>_ GROUP_gi')
  call ExecNoError('%s_\sORDER\>_ ORDER_gi')
  call ExecNoError('%s_\sWHERE\>_ WHERE_gi')
  call ExecNoError('%s_\sAND\>_   AND_gi')
  call ExecNoError('%s_\sINTO\>_ INTO_gi')
  call ExecNoError('%s_\sVALUES\>_ VALUES_gi')
  call ExecNoError('%s_}_}_g')
  call ExecNoError('%s_{_{_g')
  call ExecNoError('%s_--_--_g')
  call ExecNoError('%s_;_;_g')
  call ExecNoError('%s_\s*,\s*\(\a\)_      ,\1_g')
  call ExecNoError('%s_)\s*_) _g')

  call SQLBreakCloseingBracket('(\s*SELECT ')

  " die Subselects einrücken
  go 1
  while search('(\s*SELECT', 'W')
    let pos = line(".")
    call SQLIndent()
    exe "normal " .pos . "gg"
  endwhile 
  
  " die Klammern bei INSERT INTO (...) VALUES (...) schöner machen
  call ExecNoError('%s_\(INTO\s\w\+\)\s*(_\1 (       _g')
  call SQLBreakCloseingBracket('INTO\s\w\+\s*(')
  call ExecNoError('%s_VALUES\s*(_VALUES (       _g')
  call SQLBreakCloseingBracket('VALUES (')
  
  " am Zeilenende überall ein Space machen
  call ExecNoError('%s_\s*$__g')
  call ExecNoError('%s_$_ _g')
endfunction


" Bereich zwischen zwei matching Brackets einruecken
function SQLIndent() 
  let start = line(".") + 1
  let col = col(".") - 1
  exe "normal li\<ESC>"
  s_^\s*__
  let ende = searchpair('(', '', ')', 'W','synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
  exe start . ";" . (ende - 1) . "s_^_       _g"
endfunction


" End-Klammer suchen und umbrechen
function SQLBreakCloseingBracket(startstr)
  go 1
  while search(a:startstr, 'eW')
    let pos = line(".")
    call searchpair('(', '', ')', 'W','synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
    exe "normal i       \<ESC>"
    s_^\s*_       _
    exe "normal " . (pos + 1) . "gg"
  endwhile 
endfunction


" Damit die bloeden "Pattern not found" Exceptions weg sind.
" Das geht sicher irgenwie besser, aber keine Ahnung wie
function ExecNoError(expr)
  try
    exe a:expr
  catch 
    " ignore
  endtry 
endfunction

