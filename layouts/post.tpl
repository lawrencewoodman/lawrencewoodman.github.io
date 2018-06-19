!* commandSubst true variableSubst true
! source -directory [dir plugins] tags.tcl
! source -directory [dir plugins] posts.tcl
! set title [getparam title]
<article itemscope itemtype="http://schema.org/BlogPosting">
  <header>
    <h1 itemprop="name">
      <a href="[getvar site baseurl][getparam url]" title="$title">
        $title
      </a>
    </h1>
    <span class="post-meta">
      <time datetime="[clock format [getparam date] -format {%Y-%m-%d}]">
        [clock format [getparam date] -format {%e %B %Y}]
      </time>
      &nbsp; Tags:
!   foreach tag [getparam tags] {
      <a href="[getvar site baseurl]/blog/tag/[tags::toDirName $tag]">$tag</a>
      &nbsp; &nbsp;
!   }
    </span>

  </header>

  <div class="post-content" itemprop="articleBody">
    [getparam content]
  </div>
</article>

<div id="licence">
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a> &nbsp; <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">[getparam title]</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="[getparam url]" property="cc:attributionName" rel="cc:attributionURL">Lawrence Woodman</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
</div>


! if {[llength [getparam relatedPosts]] >= 1} {
    <div id="related">
      <h2>Related Articles</h2>
      <ul>
!     set i 0
!     foreach post [getparam relatedPosts] {
!       if {$i < 5} {
          <li>
            <a href="[getvar site baseurl][dict get $post url]">
              [dict get $post title]
            </a>
          </li>
!       }
!     }
      </ul>
    </div>
! }
