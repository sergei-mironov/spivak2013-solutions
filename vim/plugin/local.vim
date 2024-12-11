set textwidth=80
let g:terminal_images_auto = 0
let g:vimtex_enabled = 0

fun! Indent(ident_spaces)
  let &l:expandtab=1
  let &l:shiftwidth=a:ident_spaces
  let &l:tabstop=a:ident_spaces
  let &l:cinoptions="'g0,(".a:ident_spaces
  let &l:softtabstop=a:ident_spaces
endfun

let g:terminal_images2_background = 0
autocmd CursorHold,BufWinEnter * call terminal_images2#UpdateVisible()
nnoremap gi <Esc>:call terminal_images2#ShowUnderCursor()<CR>

set formatprg=formattest.sh
