let s:sizes = [
            \   [ 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 200 ],
            \   [ 150, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 150 ],
            \   [ 175, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 225 ],
            \   [ 225, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 275 ],
            \   [ 125, 125, 125, 625, 125, 125, 125, 125 ],
            \ ]

let s:captions = [
               \    '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 'Backspace',
               \    'Tab', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\',
               \    'Caps Lock', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', "'", 'Enter',
               \    'Shift', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/', 'Shift',
               \    'Ctrl', 'Win', 'Alt', 'Space', 'Alt', 'Fn', 'Win', 'Ctrl',
               \ ]

let s:hgaps = [ 10, 10, 11, 12, 19 ] " e.g. gap between Q and W
let s:vgaps = [ 10, 10, 10, 10, 10 ] " e.g. gap between Tab and Caps
let s:edgegap = 10 " gap between pic edge and top row, 
let s:keyheight = 100

function! GetAnsiKeySizes()
    return s:sizes
endfunction

function! GetAnsiKeyMap()
    return [
            \ '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '<BS>',
            \ '<Tab>', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\',
            \ 'Caps', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', "'", '<CR>',
            \ 'Shift_L', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 'Shift_R',
            \ 'Ctrl_L', 'Win_L', 'Alt_L', '<Space>', 'Alt_R', 'Fn_R', 'Win_R', 'Ctrl_R',
            \ ]
endfunction

command! Qwe :call mymaps#generateLayoutSVG(s:sizes, s:captions, s:hgaps, s:vgaps, s:edgegap, s:keyheight)


let s:t = "Test"
