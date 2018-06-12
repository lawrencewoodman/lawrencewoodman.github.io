set files {
  { filename      2015-01-01-books-read-in-2015.md
    title         "Books Read in 2015"
    tags          {"Book Reviews"}
  }

  { filename      2015-09-27-i-have-decided-to-learn-german.md
    title         "I Have Decided to Learn German"
    tags          {"German" "Language Learning"}
  }

  { filename      2015-10-18-change-of-plan-im-learning-welsh.md
    title         "Change of Plan, I'm Learning Welsh"
    tags          {"Welsh" "Language Learning"}
  }

  { filename      2015-11-18-one-month-into-say-something-in-welsh.md
    title         "One Month into Say Something in Welsh Course"
    tags          {"Welsh" "Language Learning"}
  }

  { filename      2016-07-31-ten-months-into-learning-welsh.md
    title         "Ten Months into Learning Welsh"
    tags          {"Welsh" "Language Learning"}
  }

  { filename      2017-01-01-books-read-in-2016.md
    title         "Books Read in 2016"
    tags          {"Book Reviews"}
  }

  { filename      2017-06-12-the-reading-lesson-teach-your-child-to-read-in-20-easy-lessons.md
    title         "Book Review: The Reading Lesson - Teach your child to read in 20 easy lessons by Michael Levin and Charan Langton"
    tags          {"Book Reviews"}
  }
}

# TODO: sort in date order

source -directory plugins posts.tcl
set blogURL /blog

proc makePartialContent {file filename} {
  set content [ornament [read $filename] $file]
  return [markdownify $content]
}

proc makeContent {file partialContent} {
  dict set file content $partialContent
  dict set file content [ornament [read [file join layouts post.tpl]] $file]
  return [ornament [read [file join layouts default.tpl]] $file]
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

set allTags [list]
foreach file $files {
  foreach tag [dict get $file tags] {
    if {[lsearch $allTags $tag] == -1} {
      lappend allTags $tag
      log info "collecting tags: $tag"
      collect tags $tag
    }
  }
}
log info "tags: $allTags"

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
  write [dict get $file destination] [makeContent $file $partialContent]
  collect posts $file
}
