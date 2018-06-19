namespace eval layout {
  namespace export {[a-z]*}
  namespace ensemble create
  variable config [read -directory [dir layouts] config.dict]
}

proc layout::render {layoutFilename content params} {
  # TODO: Work out whether should merge other values from
  # TODO: config template entry into params
  variable config
  if {![dict exists $config $layoutFilename]} {
    return -code error "unknown layout: $layoutFilename"
  }
  dict set params content $content
  set content [
    ornament -params $params -directory [dir layouts] $layoutFilename
  ]
  if {![dict exists $config $layoutFilename layout]} {
    return $content
  }
  set nextLayoutFilename [dict get $config $layoutFilename layout]
  return [render $nextLayoutFilename $content $params]
}
