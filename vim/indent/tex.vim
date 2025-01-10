" Only define the function once
" if exists("b:did_indent")
"   finish
" endif

" let b:did_indent = 1

call Indent(2)

let b:terminal_images_regex = '\c{\([a-z0-9_+=/$%-.]\+\.\(png\|jpe\?g\|gif\)\)}'
let b:terminal_images2_regex = '\c{\([a-z0-9_+=/$%-.]\+\.\(png\|jpe\?g\|gif\)\)}'
