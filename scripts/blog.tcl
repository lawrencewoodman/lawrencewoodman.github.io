set posts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set src [file join [getvar build content] blog index.html]
set destination [file join / blog index.html]
set vars [dict create menuOption blog posts $posts]
dict set vars content [ornament [read $src] $vars]
set content [ornament [read [file join layouts default.tpl]] $vars]
write $destination $content
