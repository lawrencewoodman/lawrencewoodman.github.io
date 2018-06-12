proc include {filename} {
 return [ornament [read -directory [getvar build includes] $filename] \
                  [getparams] \
 ]
}
