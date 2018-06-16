source -directory plugins layout.tcl
set src [file join content index.html]
set destination [file join \
    [getvar build destination] \
    [getvar site baseurl] \
    index.html
]

set params [dict create menuOption home url /index.html]
set content [ornament [read $src] $params]
write $destination [layout::render default.tpl $content $params]
