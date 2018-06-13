source -directory [getvar build plugins] layout.tcl
source -directory plugins tags.tcl

proc writeTagPage {tag posts} {
  set src [file join [getvar build content] blog tag.html]
  set destination [file join / blog tag [tags::toDirName $tag] index.html]
  set params [dict create \
    menuOption blog tag $tag posts $posts title "Articles tagged with: $tag" \
  ]
  set content [ornament [read $src] $params]
  write $destination [layout::render default.tpl $content $params]
}

set allPosts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set files [read -directory [file join [getvar build content] posts] \
          details.list]
set tags [tags::collect tags $files]
tags::generatePages $allPosts writeTagPage $tags
