source -directory [dir plugins] www.tcl
set cssDir [dir content css]
file copy [file join $cssDir *.css] \
          [file join $cssDir *.map] \
          [www::makeDestination css]

set imagesDir [dir content images]
file copy [file join $imagesDir *.png] \
          [file join $imagesDir *.jpeg] \
          [www::makeDestination images]

set fontsDir [dir content fonts]
file copy [file join $fontsDir *.eot] \
          [file join $fontsDir *.woff] \
          [file join $fontsDir *.svg] \
          [file join $fontsDir *.woff2] \
          [file join $fontsDir *.ttf] \
          [www::makeDestination fonts]

set jsDir [dir content js]
file copy [file join $jsDir *.js] [www::makeDestination js]
