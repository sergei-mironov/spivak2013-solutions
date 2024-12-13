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

" let g:sm_terminal_images_background = 0
" autocmd CursorHold,BufWinEnter * call sm_terminal_images#UpdateVisible()
" nnoremap gi <Esc>:call sm_terminal_images#ShowUnderCursor()<CR>

set updatetime=5000
set formatprg=formattest.sh

fun! LitReplPasteFix(scope) range " -> [int, string]
  let [scope] = [a:scope]
  if scope != 1
    throw "Select some text"
  endif
  let b:litrepl_ai_interpreter = "aicli-paster.py"
  let b:litrepl_ai_auxdir = $PROJECT_SOURCE."/_litrepl/ai_paster"
  try
    let result = LitReplTaskNew(scope, "/S")
  finally
    unlet b:litrepl_ai_auxdir
    unlet b:litrepl_ai_interpreter
  endtry
  return result
endfun
if !exists(":LAIPasteFix")
  command! -range -bar -nargs=0 LAIPasteFix call LitReplPasteFix(<range>!=0)
endif
