source -directory [dir plugins] layout.tcl
source -directory [dir plugins] tags.tcl

proc writeTagPage {tag posts} {
  set tagDirName [tags::toDirName $tag]
  set destination [file join \
      [dir destination] \
      [getvar site baseurl] \
      blog tag $tagDirName index.html
  ]
  set params [dict create \
    menuOption blog tag $tag posts $posts \
    url /blog/tag/$tagDirName/index.html \
    title "Articles tagged with: $tag" \
  ]
  set content [ornament \
      -params $params \
      -directory [dir content blog] \
      tag.html
  ]
  write $destination [layout::render default.tpl $content $params]
}

set allPosts [lsort \
  -command {apply {{a b} {expr {[dict get $a date] - [dict get $b date]}}}} \
  -decreasing \
  [collection posts]
]

set files [read -directory [dir content posts] details.list]
set tags [tags::collect tags $files]
tags::generatePages $allPosts writeTagPage $tags
