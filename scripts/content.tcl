source -directory [getvar build plugins] layout.tcl
set src [file join [getvar build content] index.html]
set destination [file join / index.html]

set params [dict create menuOption home]
set content [ornament [read $src] $params]
write $destination [layout::render default.tpl $content $params]
