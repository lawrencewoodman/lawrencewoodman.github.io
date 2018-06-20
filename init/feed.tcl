source -directory [dir plugins] posts.tcl

set destination [file join \
    [dir destination] \
    [getvar site baseurl] \
    feed.xml
]
set posts [posts::sort [collection posts]]
set params [dict create posts $posts]
set content [ornament -params $params -directory [dir content] -file feed.xml]
write $destination $content
