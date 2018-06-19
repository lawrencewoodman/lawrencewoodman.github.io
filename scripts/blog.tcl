source -directory plugins layout.tcl
set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set destination [file join \
    [dir destination] \
    [getvar site baseurl] \
    blog index.html
]
set params [dict create menuOption blog url /blog/index.html posts $posts]
set content [ornament \
    -params $params \
    -directory [dir content blog] \
    index.html
]
write $destination [layout::render default.tpl $content $params]
