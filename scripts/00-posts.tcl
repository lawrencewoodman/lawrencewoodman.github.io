source -directory [getvar build plugins] posts.tcl
source -directory [getvar build plugins] layout.tcl
source -directory [getvar build plugins] tags.tcl

proc makePartialContent {file filename} {
  set content [ornament [read $filename] $file]
  return [markdownify $content]
}

# TODO: sort in date order
set files [read -directory [file join [getvar build content] posts] \
          details.list]
set blogURL /blog

set files [lmap file $files {
  dict set file filename [
    file join [getvar build content ] posts [dict get $file filename] \
  ]
  dict set file destination \
           [posts::makeDestination $blogURL [dict get $file filename]]
  dict set file tags [lsort [dict get $file tags]]
  dict set file url [posts::makeURL $blogURL [dict get $file filename]]
  dict set file date [posts::makeDate $file]
  dict set file menuOption article
  set file
}]

foreach file $files {
  dict set file relatedPosts [posts::makeRelated $files $file]
  set partialContent [makePartialContent $file [dict get $file filename]]
  dict set file summary [posts::makeExcerpt $partialContent]
  collect posts $file
  write [dict get $file destination] \
        [layout::render post.tpl $partialContent $file]
}
