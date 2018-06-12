# TODO: Put this into a plugin
proc makeContent {file filename} {
  dict set file content [ornament [read $filename] $file]
  return [ornament [read [file join layouts default.tpl]] $file]
}

set destination [file join / index.html]
set filename [file join [getvar build content] index.html]

set file [dict create menuOption home]
write $destination [makeContent $file $filename]
