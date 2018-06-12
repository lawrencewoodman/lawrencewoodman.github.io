namespace eval tags {
  namespace export {[a-z]*}
  namespace ensemble create
}

proc tags::toDirName {tag} {
 return [string tolower [regsub -all {[^[:alnum:]_-]} $tag {}]]
}

proc tags::generatePages {files writeCommand {tags {}}} {
  log info "tag::generatePages tags: $tags"
  foreach tag $tags {
    set tagFiles [list]
    set tagFileIndices [list]
    foreach file $files {
      if {![dict exists $file tags]} {
        continue
      }
      if {[lsearch [dict get $file tags] $tag] >= 0} {
        lappend tagFiles $file
      }
    }
    $writeCommand $tag $tagFiles
  }
}
