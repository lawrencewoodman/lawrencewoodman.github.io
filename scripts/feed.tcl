set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set src [file join [getvar build content] feed.xml]
set destination [file join / feed.xml]
set vars [dict create posts $posts]
set content [ornament [read $src] $vars]
write $destination $content
