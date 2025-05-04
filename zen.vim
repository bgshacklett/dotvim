" goyo and limelight
" let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 50  " Keep it readable: https://baymard.com/blog/line-length-readability
" let g:goyo_height = 80
let b:code = "no"

" Toggle Goyo and Limelight on and off
function! ToggleCoding()
    if exists("b:code") && b:code == "yes"
        let b:code = "no"
        Goyo!
        Limelight!
    else
        let b:code = "yes"
        Goyo
        Limelight
    endif
endfunction

" remove weird background change on exit 
function s:goyo_enter()
  set wrap
  set lbr
  map j gj
  map k gk

"     hi! VertSplit guibg=None
"     hi! StatusLineNC guifg= guibg=None
"     hi! EndOfBuffer guifg=#1d1f22
endfunction

function s:goyo_leave()
  set nowrap
  set nolbr
  unmap j
  unmap k

  " hi Normal guibg=NONE ctermbg=NONE
  " hi NonText ctermbg=none ctermfg=NONE 
  " hi EndOfBuffer ctermbg=none
  " hi LineNr ctermbg=none
  " hi! EndOfBuffer guifg=#323b3e
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


command DFW call ToggleCoding()
