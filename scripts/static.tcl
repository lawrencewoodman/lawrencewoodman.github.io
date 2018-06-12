set cssDir [file join [getvar build content] css]
file copy [file join $cssDir *.css] \
          [file join $cssDir *.map] \
          [file join / css]

set imagesDir [file join [getvar build content] images]
file copy [file join $imagesDir *.png] \
          [file join $imagesDir *.jpeg] \
          [file join / images]

set fontsDir [file join [getvar build content] fonts]
file copy [file join $fontsDir *.eot] \
          [file join $fontsDir *.woff] \
          [file join $fontsDir *.svg] \
          [file join $fontsDir *.woff2] \
          [file join $fontsDir *.ttf] \
          [file join / fonts]

set jsDir [file join [getvar build content] js]
file copy [file join $jsDir *.js] [file join / js]
