source -directory plugins tags.tcl

proc writeTagPage {tag posts} {
  set src [file join [getvar build content] blog tag.html]
  set destination [file join / blog tag [tags::toDirName $tag] index.html]
  set params [dict create \
    menuOption blog tag $tag posts $posts title "Articles tagged with: $tag" \
  ]
  dict set params content [ornament [read $src] $params]
  set content [ornament [read [file join layouts default.tpl]] $params]
  write $destination $content
}

set allPosts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set tags [collection tags]
log info "scripts/tags.tcl - tags: $tags"

set params [dict create menuOption blog]
tags::generatePages $allPosts writeTagPage [collection tags]
