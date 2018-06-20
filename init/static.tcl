proc makeDestinationDir {dir} {
  return [file join [dir destination] [getvar site baseurl] $dir]
}

set cssDir [dir content css]
file copy [file join $cssDir *.css] \
          [file join $cssDir *.map] \
          [makeDestinationDir css]

set imagesDir [dir content images]
file copy [file join $imagesDir *.png] \
          [file join $imagesDir *.jpeg] \
          [makeDestinationDir images]

set fontsDir [dir content fonts]
file copy [file join $fontsDir *.eot] \
          [file join $fontsDir *.woff] \
          [file join $fontsDir *.svg] \
          [file join $fontsDir *.woff2] \
          [file join $fontsDir *.ttf] \
          [makeDestinationDir fonts]

set jsDir [dir content js]
file copy [file join $jsDir *.js] [makeDestinationDir js]
