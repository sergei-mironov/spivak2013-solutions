set formatoptions-=c
set formatoptions-=r
set formatoptions-=o
command! -buffer -nargs=0 C normal 0i\begin{python}<CR><CR>\end{python}<CR><CR>\begin{result}<CR>\end{result}<Esc>4k
command! -buffer -nargs=0 AI normal zz10<C-e>0i%lai<CR><CR>%lnoai<CR><CR>%lresult<CR>%lnoresult<Esc>04k
command! -buffer -nargs=0 I normal a<C-f>\ls <CR>\le<Esc>k$
command! -buffer -nargs=0 E normal a<C-f>\es <CR>\ee<Esc>k$
