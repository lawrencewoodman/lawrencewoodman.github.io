source -directory plugins posts.tcl
source -directory plugins layout.tcl
source -directory plugins tags.tcl

proc makePartialContent {file filename} {
  set content [ornament [read $filename] $file]
  return [markdownify $content]
}

# TODO: sort in date order
set files [read -directory [file join content posts] details.list]

set files [lmap file $files {
  dict set file filename [
    file join content posts [dict get $file filename] \
  ]
  dict set file destination [file join \
      [getvar build destination] \
      [getvar site baseurl] \
      blog \
      [posts::makeDestination [dict get $file filename]]
  ]
  dict set file tags [lsort [dict get $file tags]]
  dict set file url "/blog/[posts::makeURL [dict get $file filename]]"
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
