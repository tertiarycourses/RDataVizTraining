library(ggmap)
library(dplyr)

spd=read.csv("C://Users//user//Desktop//tertiary//Rgraphics//datasets//spd.csv",
             header=T, strip.white=T)
spd=spd %>% filter(Year >=2014 & Year<2016)
bike_theft=filter(spd, Summarized.Offense.Description =="BIKE THEFT")


####### using ggmap

seattle_map=ggmap(get_map('Seattle','Washington',
                          zoom=11, scale=2,
                          source='google', maptype='terrain'),
                  base_layer= ggplot(aes(x=Longitude, y=Latitude),
                                     data=bike_theft))


# point map of bike theft
seattle_map + geom_point(alpha=0.5, size=0.5) +
  scale_alpha(guide=F)+
  ggtitle('Seattle Bike Thefts (2014-2015)')+
  xlab('')+
  ylab('')+
  theme(axis.ticks=element_blank(), axis.text=element_blank(),
        legend.position='none')

# density map of bike theft by year
seattle_map +
  stat_density2d(aes(fill=..level..),
                 alpha=0.5,
                 bins=10,
                 geom='polygon')+
  scale_alpha(guide=F)+
  ggtitle('Seattle Bike thefts(2014-2015)')+
  xlab('')+
  ylab('')+
  facet_wrap(~Year)+
  theme(axis.ticks=element_blank(), axis.text=element_blank(),
        legend.position='none')


######## using leaflet

library(leaflet)

bike_theft_dec=bike_theft %>% filter(Year==2014 & Month==12)

bike_theft_jan=bike_theft %>% filter(Year==2015 & Month==1)

bike_theft_interactive=leaflet() %>%
  addTiles() %>%
  setView(-122.3397, 47.6144, zoom=13) %>%
  addCircleMarkers(data=bike_theft_dec,
                   lat=~Latitude,
                   lng=~Longitude,
                   popup=bike_theft$Hundred.Block.Location,
                   group="December 2014",
                   fillOpacity=0.25,
                   color="red",
                   radius=4) %>%
  addCircleMarkers(data=bike_theft_jan,
                   lat=~Latitude,
                   lng=~Longitude,
                   popup=bike_theft$Hundred.Block.Location,
                   group="January 2015",
                   fillOpacity=0.25,
                   color="blue",
                   radius=4) %>%
  addLayersControl(overlayGroups=c("December 2014", "January 2015"),
                   options=layersControlOptions(collapsed=F)) %>%
  addLegend("bottomright", title="Legend",
            colors=c("red","blue"), labels=c("December 2014","January 2015"))


bike_theft_interactive
