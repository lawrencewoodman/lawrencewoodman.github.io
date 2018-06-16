source -directory plugins layout.tcl
set destination [file join \
    [getvar build destination] \
    [getvar site baseurl] \
    index.html
]

set params [dict create menuOption home url /index.html]
set content [ornament \
    -params $params \
    -directory content \
    index.html
]
write $destination [layout::render default.tpl $content $params]
