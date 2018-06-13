source -directory [getvar build plugins] posts.tcl
source -directory [getvar build plugins] layout.tcl
source -directory [getvar build plugins] tags.tcl

proc makePartialContent {file filename} {
  set content [ornament [read $filename] $file]
  return [markdownify $content]
}

# Return any files related to the supplied file
# This is done by looking at the tags
proc makeRelatedPosts {files file} {
  set fileTags [dict get $file tags]
  set relatedFileStats [lmap oFile $files {
    set numTagsMatch 0
    foreach oTag [dict get $oFile tags] {
      if {[lsearch $fileTags $oTag] >= 0 &&
          [dict get $file filename] ne [dict get $oFile filename]} {
        incr numTagsMatch
      }
    }
    if {$numTagsMatch == 0} {
      continue
    }
    list $numTagsMatch $oFile
  }]

  set relatedFileStats [lsort -decreasing -command {apply {{a b} {
    set aNumTags [lindex $a 0]
    set bNumTags [lindex $b 0]
    set numTagsDiff [expr {$aNumTags - $bNumTags}]
    if {$numTagsDiff != 0} {
      return $numTagsDiff
    }
    return [expr {[dict get [lindex $a 1] date] -
                  [dict get [lindex $b 1] date]}]
  }}} $relatedFileStats]
  return [lmap x $relatedFileStats {lindex $x 1}]
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
  set file
}]

foreach file $files {
  dict set file menuOption article
  set partialContent [makePartialContent $file [dict get $file filename]]
  dict set file summary [posts::makeExcerpt $partialContent]
  dict set file relatedPosts [makeRelatedPosts $files $file]
  write [dict get $file destination] \
        [layout::render post.tpl $partialContent $file]
  collect posts $file
}
