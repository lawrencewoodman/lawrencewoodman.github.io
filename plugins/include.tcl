proc include {filename} {
 return [ornament [read -directory includes $filename] [getparams]]
}
