" Only define the function once
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

fun! LocalTexIndent(lnum) abort
  let curr_line = getline(a:lnum)
  let prev_lnum = a:lnum - 1
  if prev_lnum <= 0 | return -1 | endif
  let prev_line = getline(prev_lnum)

  let m=matchstrpos(curr_line,'\\ei\|\\item\|\\end\|\\ee')
  if m[1]>=0 | return m[1]-len(m[0]) | endif

  let m=match(prev_line,'\\eb\|\\ei\|\\item')
  let m=matchstrpos(prev_line,'\\eb\|\\ei\|\\item')
  if m[1]>=0 | return m[1]+len(m[0]) | endif

  let ws=matchstr(l:prev_line,'^[ ]*')
  if len(ws)>0 | return len(ws) | endif

  return -1
endfun

setlocal indentexpr=LocalTexIndent(v:lnum)
setlocal indentkeys=!^F,<Space>,0=\\end,o,O
