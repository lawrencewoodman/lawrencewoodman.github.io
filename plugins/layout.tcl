namespace eval layout {
  namespace export {[a-z]*}
  namespace ensemble create
  variable config [read -directory [getvar build layouts] config.dict]
}

proc layout::render {layoutFilename content params} {
  # TODO: Work out whether should merge other values from
  # TODO: config template entry into params
  variable config
  if {![dict exists $config $layoutFilename]} {
    return -code error "unknown layout: $layoutFilename"
  }
  set tpl [read -directory [getvar build layouts] $layoutFilename]
  dict set params content $content
  set content [ornament $tpl $params]
  if {![dict exists $config $layoutFilename layout]} {
    return $content
  }
  set nextLayoutFilename [dict get $config $layoutFilename layout]
  return [render $nextLayoutFilename $content $params]
}
