#map learning example
#http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

#Author: Barry von Tobel

#Setting the working directory
setwd("/home/bvt/Dropbox/eng_science/R/wd/geo")


#Load required packages
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

world2 <- map_data("world2")
w2hr <- map_data("world2Hires")
usa <- map_data("usa")
world2legacy <- map_data("world.legacy")

#check dimensions and array size

#dim(world2)
dim(w2hr)

#head(world2)

#tail(world2)




gg1 <- ggplot() + 
  geom_polygon(data = world2, aes(x=long, y = lat, group = group), fill = "violet", color = "blue") + 
  coord_fixed(1.3)


#country maps
countries <- map_data("world2")
dim(countries)
head(countries)
tail(countries)
##
ggplot(data = world2) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend

##plot a subset of the countries

countries <- subset(world2, region %in% c("Australia", "USA", "Aruba"))

gg2 <-ggplot(data = countries) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)
#adding points to the map

labs <- data.frame(
  lat = c(-21.809663428, -34.73333, 21.5105, 39.96118, 42.624),
  long = c(114.15916603, 138.63418, 202.02092, 277.0, 288.5),
  names = c("HEH", "1RSU", "Wahiawa", "EM", "Haystack"),
  stringsAsFactors = FALSE
)  
gg2 + 
  geom_point(data = labs, aes(x = long, y = lat), color = "black", size = 5) +
  geom_point(data = labs, aes(x = long, y = lat), color = "yellow", size = 3)
## explore the theme
gg1 + theme_classic()

#explore the counties
ca_df <- subset(states, region == "california")
#get the county lines
counties <- map_data("county")
ca_county <- subset(counties, region == "california")


ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")

ca_base + theme_classic()
#plot the counties in white
ca_base + theme_classic() + 
  geom_polygon(data = ca_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top

