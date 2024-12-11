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

  let m=matchstrpos(curr_line,'\\li\|\\ei\|\\item\|\\end\|\\le\|\\ee')
  if m[1]>=0 | return m[1]-len(m[0])-1 | endif

  let m=matchstrpos(prev_line,'\\ls\|\\es\|\\ei\|\\li\|\\item')
  if m[1]>=0 | return m[1]+len(m[0])+1 | endif

  let ws=matchstr(l:prev_line,'^[ ]*')
  if len(ws)>0 | return len(ws) | endif

  return -1
endfun

setlocal indentexpr=LocalTexIndent(v:lnum)
setlocal indentkeys=!^F,<Space>,o,O,0(,0),],},&,=\\li\ ,=\\le,=\\ei\ ,=\\ee

call Indent(2)

let b:terminal_images_regex = '\c{\([a-z0-9_+=/$%-.]\+\.\(png\|jpe\?g\|gif\)\)}'
let b:terminal_images2_regex = '\c{\([a-z0-9_+=/$%-.]\+\.\(png\|jpe\?g\|gif\)\)}'
