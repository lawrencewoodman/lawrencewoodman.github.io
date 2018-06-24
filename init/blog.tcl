source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

set destination [www::makeDestination blog index.html]
set posts [posts::sort [collection get posts]]
set params [dict create menuOption blog url /blog/index.html posts $posts]
set content [ornament \
    -params $params \
    -directory [dir content blog] \
    -file index.html
]
write $destination [layout::render default.tpl $content $params]
