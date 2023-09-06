#29Jan18 - removed all the clutter and focusing on Illinois (or the midwest), show the counties and the lat/log of various sensors
#loate some statistics of the sensors and portray them on the map
#map learning examples
#http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
# working a subset of this tutorial
#Author: Barry von Tobel

#Setting the working directory
setwd("/home/bvt/Dropbox/eng_science/R/wd/geo")


#Load required packages
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
#map_data uses the maps package
GREON_704 <- read.csv("704.csv")
GREON_715 <- read.csv("715.csv")
##plot a subset
sensors <- data.frame(
  long = c(-88.859, -91.281),
  lat = c(39.889, 43.833),
  names = c("714","704"),
  stringsAsFactors = FALSE
)
midwest <- subset(states, region %in% c("illinois", "indiana", "wisconsin"))

midwest1 <- ggplot(data = midwest) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)

midwest1 +
        geom_point(data = sensors, aes(x = long, y = lat), color = "red", size = 3, inherit.aes = FALSE)


#

