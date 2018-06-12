namespace eval posts {
  namespace export {[a-z]*}
  namespace ensemble create
}

proc posts::makeDate {post} {
  set date ""
  if {[dict exists $post date]} {
    set date [dict get post date]
    log info "[dict get $post filename]: post-date: [dict get $post date]"
  }
  if {$date ne ""} {
    return [clock scan $date -format {%Y-%m-%d}]
    # TODO: output warning if can't read format
  } elseif {[dict exists $post filename]} {
   set filename [file tail [dict get $post filename]]
    set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-.*$} \
                   $filename match year month day \
    ]
    log info "[dict get $post filename]: ok: $ok"
    if {$ok} {
      log info "[dict get $post filename]: year: $year month: $month day: $day"
      return [clock scan "$year-$month-$day" -format {%Y-%m-%d}]
    }
  } else {
    # TODO: output warning if can't read format
    return [clock seconds]
  }
}

proc posts::makeExcerpt {partialContent} {
  return [string range [strip_html $partialContent] 0 300]
}

proc posts::makeDestination {blogURL filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return [file join $blogURL $year $month $day $titleDir index.html]
  }
  # TODO: Raise an error
}

proc posts::makeURL {blogURL filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return "$blogURL/$year/$month/$day/$titleDir/"
  }
  # TODO: Raise an error
}

# Displays the rating as a series of stars
proc posts::starRating {rating} {
  set starImgTag "<img src=\"/images/%s\" alt=\"%.1f/5.0\" />"

  set wholeStars [expr {floor($rating)}]
  if {$rating - $wholeStars > 0.5} {
    incr wholeStars - 1
  }

  set halfStar [expr {($rating - $wholeStars == 0.5 ? 1 : 0)}]
  set clearStars [expr {5 - ($wholeStars + $halfStar)}]

  set htmlOutput ""
  for {set i 0} {$i < $wholeStars} {incr i} {
    append htmlOutput [format $starImgTag "star_filled.png" $rating]
  }

  if {$halfStar == 1} {
    append htmlOutput [format $starImgTag "star_half.png" $rating]
  }

  for {set i 0} {$i < $clearStars} {incr i} {
    append htmlOutput [format $starImgTag "star_clear.png" $rating]
  }

  return "$htmlOutput"
}
