!* commandSubst true
! source -directory plugins include.tcl
<!DOCTYPE html>
<html>

 [include head.html]

  <body>
    [include header.html]
    <div id="content" class="container">
      [getparams content]
    </div><!-- /.container -->

!   if {[getparams menuOption] ne "home"} {
      [include footer.html]
!   }
  </body>
</html>

