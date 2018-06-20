namespace eval www {
  namespace export {[a-z]*}
}

# Prefix url with plugins > www > baseurl
# Options:
#   -full        Take prefixed url and prefix with plugins > www > url
#   -canonical   Take prefixed url and prefix it with plugins > www > url
#                and remove the index.html
proc www::url {args} {
  array set options {canonical 0 full 0}
  while {[llength $args]} {
    switch -glob -- [lindex $args 0] {
      -can*   {set options(canonical) 1 ; set args [lrange $args 1 end]}
      -full   {set options(full) 1 ; set args [lrange $args 1 end]}
      --      {set args [lrange $args 1 end] ; break}
      -*      {error "url: unknown option [lindex $args 0]"}
      default break
    }
  }
  if {[llength $args] != 1} {
    return -code error "url: invalid number of arguments"
  }
  lassign $args url
  set url [getvar plugins www baseurl]$url

  if {$options(canonical) || $options(full)} {
    set url [getvar plugins www url]$url
  }
  if {$options(canonical)} {
    # Remove index.html if present
    set indexPos [string last "index.html" $url]
    if {$indexPos >= 0 } {
      set url [string range $url 0 $indexPos-1]
    }
  }
  return $url
}
