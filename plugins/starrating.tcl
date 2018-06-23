namespace eval starRating {
  namespace export {[a-z]*}
  source -directory [dir plugins] www.tcl
}

# Displays the rating as a series of stars
# Images msut be stored in [dir starImages]
proc starRating::starRating {rating} {
  set imagesURL [www::url [getvar plugins starRating imagesURL]]
  set starImgTag "<img src=\"$imagesURL/%s\" alt=\"%.1f/5.0\" />"

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
