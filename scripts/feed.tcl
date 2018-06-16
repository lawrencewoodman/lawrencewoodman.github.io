set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set destination [file join \
    [getvar build destination] \
    [getvar site baseurl] \
    feed.xml
]
set params [dict create posts $posts]
set content [ornament -params $params -directory content feed.xml]
write $destination $content
