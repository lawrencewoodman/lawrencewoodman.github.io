source -directory [getvar build plugins] layout.tcl
set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set src [file join [getvar build content] blog index.html]
set destination [file join / blog index.html]
set params [dict create menuOption blog posts $posts]
set content [ornament [read $src] $params]
write $destination [layout::render default.tpl $content $params]
