
############################ geographic mapping 

library(maps)
library(ggmap)
library(mapproj)
library(ggplot2)

# get map of england
map <- get_map(location = 'England', zoom = 7)
ggmap(map)


## map of chicago
chicago=get_map(location="chicago", zoom=5, source='google', maptype='terrain')
ggmap(chicago)


## USA map
statesMap=map_data("state")  # plotting map of USA
str(statesMap)
ggplot(statesMap, aes(x=long, y=lat, group=group)) + geom_polygon(fill="white", color="black")


## world map
world_map=map_data("world")
str(world_map)
ggplot(world_map, aes(x=long, y=lat, group=group)) + geom_polygon(fill="white", color="black")


library(rworldmap)
library(rworldxtra)
newMap=getMap(resolution="high")
plot(newMap, col="wheat2", pch=19)



####################### Regional Maps

library(maps)
map(database= 'state', regions= 'indiana')

#let us use this example dataframe

monitors <- read.table(header=TRUE, text='
  monitorid        lat        long                       name            
          1   41.60668  -87.304729                 Gary-IITRI
          2  39.811097  -86.114469     Indpls-Washington-Park
          3  39.749019  -86.186314         Indpls-Harding-St.
          4  38.013248  -87.577856     Evansville-Buena-Vista
          5  39.159383  -86.504762                Bloomington
          6  39.997484  -86.395172                 Whitestown
                       ')

points(x=monitors$long, y=monitors$lat)

# better visualization
map(database='state', regions='indiana')
points(x=monitors$long, y=monitors$lat, pch=19, col='red')

# specific counties with labelling
map(database='state', regions=c('indiana,marion','indiana.boone'))
points(x=monitors$long, y=monitors$lat, pch=19, col='red')
title(main="Air monitor locations")
text(x=monitors$long, y=monitors$lat, labels=monitors$name, pos=2)




####################### Choropleth Maps

# to use the choroplethr package the state names must be labelled "region"
# and the column with numeric values labelled "value"

nonattain <- read.table(header=TRUE, text='
      region   value
   illinois      2
    indiana      2
   michigan      0
       ohio      3
  wisconsin      2
                      ')

library(choroplethr)
library(choroplethrMaps)

mapper=state_choropleth(nonattain, zoom=nonattain$region, title="ozone nonattainment",
			legend="Areas")
mapper



data("df_pop_country")

country_choropleth(df_pop_country)


country_choropleth(df_pop_country,
                   legend="Country\nPopulation", num_colors = 1)

country_choropleth(df_pop_country,
                   legend="Country\nPopulation", num_colors = 1,
                   zoom="china")

country_choropleth(df_pop_country,
                   legend="Country\nPopulation", num_colors = 1,
                   zoom="canada")


##################### Leaflet maps

library(leaflet)
m=leaflet() %>% addTiles()%>% 
  addMarkers(lng=monitors$long, lat=monitors$lat, popup=monitors$name)
m


r=leaflet() %>% addTiles()%>%
  addMarkers(lng=174.768, lat=-36.852, popup="the birthplace of R")
r


taj=leaflet() %>%
  addTiles() %>%
  setView(lng=78.0419, lat=27.1750, zoom=15) %>%
  addMarkers(lng=78.0419, lat=27.1750, popup="Taj Mahal")
taj

# save map as HTML
library(htmlwidgets)
saveWidget(widget=taj, file="tajMahal.html")


###################### tMaps

library(tmap)
library(tmaptools)
data(Europe)
qtm(Europe)

qtm(Europe, fill="well_being", text="iso_a3", text.size="AREA", format="Europe", style="gray",
            text.root=5, fill.title="Well-Being Index", fill.textNA="Non-European countries")


####################### Contour Maps

# used to display data related to temperatur or topographic infomation

data(volcano)
contour(volcano, main="Topographic map of volcano", col="blue")
filled.contour(volcano, color.palette = terrain.colors, main="Topographic map of volcano")


x=seq(-10,10, length=30)
y=x
f=function(x,y){
  r=sqrt(x^2 + y^2)
  10*sin(r)/r
}
z=outer(x,y,f)
contour(x,y,z)


####################### Cartograms

library(cartogram)
library(tmap)
library(maptools)

data(wrld_simpl)

afr=wrld_simpl[wrld_simpl$REGION==2,]
afr=spTransform(afr, CRS("+init=epsg:3395"))

# normal map
afrc=nc_cartogram(afr, "POP2005")
tm_shape(afr)+tm_borders()+ tm_shape(afrc) + tm_fill("POP2005", style="jenks") + tm_borders() + tm_layout(frame=F)

# cartogram
afrc2=cartogram(afr, "POP2005", itermax=5)
tm_shape(afrc2) + tm_fill("POP2005", style="jenks") + tm_borders() + tm_layout(frame=F)

# there is an error "spDists" package needs to be updated

