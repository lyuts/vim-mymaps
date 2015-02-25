
function! mymaps#generateLayoutSVG(sizes, captions, hgaps, vgaps, edgegap, keyheight)
    let numrows = len(a:sizes)
    let row = 0

    let buttons = []

    let y = a:edgegap
    let btnnumber = 0
    while row < numrows
        let x = a:edgegap
        let col = 0
        for keysize in a:sizes[row]
            let btn = {}
            let btn.x = x
            let btn.y = y
            let btn.height = a:keyheight
            let btn.width = keysize
            let btn.label = a:captions[btnnumber]
            let btn.labelx = btn.x + btn.width / 10
            let btn.labely = btn.y + btn.height / 2
            call add(buttons, btn)

            let x = x + a:hgaps[row]
            let x = x + keysize
            let col = col + 1
            let btnnumber = btnnumber + 1
        endfor
        let y = y + a:vgaps[row]
        let y = y + a:keyheight
        let row = row + 1
    endwhile

    let head = '<svg  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
    let tail = '</svg>' 

    let lines = []

    call add(lines, head)
    for btn in buttons
"        let line = '<g> <rect rx="10" ry="10" x="'.btn.x.'" y="'.btn.y.'" height="'.btn.height.'" width="'.btn.width.'" style="stroke:#ff0000; fill: #ffffff"/> <text x="'.btn.labelx.'" y="'.btn.labely.'">'.btn.label.'</text> </g>'
        let line = printf('<g> <rect rx="10" ry="10" x="%s" y="%s" height="%s" width="%s" style="stroke:#333333; fill: #ffffff"/> <text x="%s" y="%s">%s</text> </g>', btn.x, btn.y, btn.height, btn.width, btn.labelx, btn.labely, btn.label)
        call add(lines, line)

    endfor
    call add(lines, tail)

    let tmpfname = tempname().'.svg'
    echomsg tmpfname
    call writefile(lines, tmpfname)

    " temp
    execute ":!display ".tmpfname
endfunction

"
" <Leader>a -> <Leader>
" ab -> a
"
function! mymaps#ExtractNextKeyFromMapping(mapping)
    if strlen(a:mapping) == 0
        return ''
    endif

    if a:mapping[0] == '<'
        return strpart(a:mapping, 0, stridx(a:mapping, '>') + 1)
    else
        return a:mapping[0]
    endif
endfunction

"
" prefix, key to build the mapping layout relative to, e.g. <leader>
" mode - nmap/imap/vmap
"
function! mymaps#buildMappingsLayout(prefix, mode)
    redir => nmaps
        silent! execute a:mode
    redir END

    let mapdict = {}
    for mapping in split(nmaps, '\n\+')
"        let sections = split(mapping, '\s\{2,\}\|*')
        let sections = split(mapping, '[\s*]\{2,\}')
        let rhs = sections[-1]
        let lhs = sections[-2]

        if stridx(rhs, '<Plug>') != -1
            continue
        endif

        if len(sections) > 2
            let mode = sections[-3]
        endif

        if strlen(a:prefix) > 0
            let firstKey = mymaps#ExtractNextKeyFromMapping(strpart(lhs, stridx(lhs, a:prefix) + strlen(a:prefix)))
        else
            let firstKey = mymaps#ExtractNextKeyFromMapping(lhs)
            if index([ '<Plug>', '<SNR>' ], firstKey) != -1
                continue
            endif
        endif

        if strlen(firstKey) > 0 && !has_key(mapdict, firstKey)
            let mapdict[firstKey] = []
        endif

        call add(mapdict[firstKey], rhs)

        echo printf('%s -> %s              %s', lhs, firstKey, mapping)
        sleep 1

"        echo sections
    endfor

    let ansimap = GetAnsiKeyMap()
    let captions = []
    for k in ansimap
        if !has_key(mapdict, k)
            call add(captions, '')
            continue
        endif
"        echo k
        echo k.' has '.len(mapdict[k]).' mappings'
"        sleep 1
        if len(mapdict[k]) > 1
            call add(captions, '... '.len(mapdict[k]))
        else
            let escapedcaption = mapdict[k][0]
            let escapedcaption = substitute(escapedcaption, '<', '\&lt;', 'g')
            let escapedcaption = substitute(escapedcaption, '>', '\&gt;', 'g')

"            echo escapedcaption
"            sleep 3
            call add(captions, escapedcaption)
        endif
    endfor
    call mymaps#generateLayoutSVG(GetAnsiKeySizes(), captions, [ 10, 10, 11, 12, 19 ], [ 10, 10, 10, 10, 10 ], 10, 100)
endfunction

