#map learning examples
#http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

#Author: Barry von Tobel

#Setting the working directory
setwd("/home/bvt/Dropbox/eng_science/R/wd/geo")


#Load required packages
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
#map_data uses the maps package
world2 <- map_data("world2")
w2hr <- map_data("world2Hires")
usa <- map_data("usa")

#check dimensions and array size
dim(usa)

head(usa)

tail(usa)

ggplot() +  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "red") + 
  coord_fixed(1.3)

gg1 <- ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "violet", color = "blue") + 
  coord_fixed(1.3)
#adding points to the map

labs <- data.frame(
  long = c(-122.064873, -118.306417),
  lat = c(36.951968, 34.644855),
  names = c("SWFSC-FED", "NWFSC"),
  stringsAsFactors = FALSE
)  
gg1 + 
  geom_point(data = labs, aes(x = long, y = lat), color = "green", size = 5) +
  geom_point(data = labs, aes(x = long, y = lat), color = "yellow", size = 3)

#state maps
states <- map_data("state")
dim(states)
head(states)
tail(states)
##
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend
##plot a subset
midwest <- subset(states, region %in% c("illinois", "indiana", "wisconsin"))

ggplot(data = midwest) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)
## explore the theme
gg1 + theme_bw()

#explore the counties
il_df <- subset(states, region == "illinois")
#get the county lines
counties <- map_data("county") # typing counties will show the list
il_county <- subset(counties, region == "illinois")


il_base <- ggplot(data = il_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray") 

#ca1 <- ca_base + theme_nothing() # or theme_classic
#plot the counties in white
il1 <- il_base + 
  theme_classic() + 
  geom_polygon(data = il_county, fill = NA, color = "blue") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top +

  
il1 +
  geom_point(data = labs, aes(x = long, y = lat), color = "green", size = 5) +
  #geom_point(data = labs, aes(x = long, y = lat), color = "yellow", size = 4) 
  

#now he adds demographic information

