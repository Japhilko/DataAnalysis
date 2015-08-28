#--------------------------------#
# Color in R
# Jan-Philipp Kolb
# Fri Aug 28 10:27:13 2015
#--------------------------------#


require(graphics)
# A Color Wheel
pie(rep(1, 12), col = rainbow(12))

##------ Some palettes ------------
demo.pal <-
  function(n, border = if (n < 32) "light gray" else NA,
           main = paste("color palettes;  n=", n),
           ch.col = c("rainbow(n, start=.7, end=.1)", "heat.colors(n)",
                      "terrain.colors(n)", "topo.colors(n)",
                      "cm.colors(n)"))
  {
    nt <- length(ch.col)
    i <- 1:n; j <- n / nt; d <- j/6; dy <- 2*d
    plot(i, i+d, type = "n", yaxt = "n", ylab = "", main = main)
    for (k in 1:nt) {
      rect(i-.5, (k-1)*j+ dy, i+.4, k*j,
           col = eval(parse(text = ch.col[k])), border = border)
      text(2*j,  k * j + dy/4, ch.col[k])
    }
  }
n <- if(.Device == "postscript") 64 else 16
# Since for screen, larger n may give color allocation problem
demo.pal(n)

#--------------------------------#
# Presentation about color in R
#--------------------------------#


# http://research.stowers-institute.org/efg/Report/UsingColorInR.pdf
library(gplots) 
palette(rev(rich.colors(32)))

#--------------------------------#
# Links
#--------------------------------#

# http://vis.supstat.com/2013/04/plotting-symbols-and-color-palettes/

# http://www.r-bloggers.com/color-palettes-in-r/
