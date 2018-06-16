set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set src [file join content feed.xml]
set destination [file join \
    [getvar build destination] \
    [getvar site baseurl] \
    feed.xml
]
set vars [dict create posts $posts]
set content [ornament [read $src] $vars]
write $destination $content
