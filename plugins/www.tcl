namespace eval www {
  namespace export {[a-z]*}
  namespace ensemble create
}

# Take a url and prefix it with the site url, baseurl and remove the index.html
proc www::canonicalURL {url} {
  set canonicalURL [format "%s%s%s" \
    [getvar site url] \
    [getvar site baseurl] \
    $url
  ]
  set indexPos [string last "index.html" $canonicalURL]
  if {$indexPos >= 0 } {
    set canonicalURL [string range $canonicalURL 0 $indexPos-1]
  }
  return $canonicalURL
}
