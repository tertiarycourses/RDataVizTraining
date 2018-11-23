# Module 4 Geospatial Visualizations

# Load the Tidyverse
library(tidyverse)
library(ggmap)

# Insert your own API Key below
register_google(key="AIzaSyCLZm8aiXlx_maMmlm_3_UpxXnuGMCkFxQ")

map <- get_map(location = 'Singapore', zoom = 10)
ggmap(map)

tc <- geocode("Tertiary Courses Singaoore")
tc


# Experiment with different map types
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "terrain"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "roadmap"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "terrain-labels"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "terrain-lines"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "satellite"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "hybrid"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "toner"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "toner-lite"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "toner-background"))
ggmap(get_map(location = 'Singapore', zoom = 10, maptype = "watercolor"))

# Plot a point on the map
ggmap(get_map(location = 'Singapore', zoom = 10)) +
  geom_point(color="red",data=tc) + aes(x=lon, y=lat)

# Create a tibble of locations
placenames <- c("Tampines Singapore", "Choa Chu Kang Singapore", "Setosa Singapore", "Jurong East Singapore")
locations <- geocode(placenames)
places <- tibble(name=placenames, lat=locations$lat, lon=locations$lon)

# Plot the locations on the map
ggmap(get_map(location = 'Singapore', zoom=10)) +
  geom_point(color="red",data=places) + aes(x=lon, y=lat)


# Plot the locations on the map
ggmap(get_map(location = 'Singapore', zoom=10)) +
  geom_point(color="red",data=places) + aes(x=lon, y=lat) + 
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places)


# Load the college dataset
college <- read_csv('http://672258.youcanlearnit.net/college.csv')
college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region),
         highest_degree=as.factor(highest_degree),
         control=as.factor(control), gender=as.factor(gender),
         loan_default_rate=as.numeric(loan_default_rate))

# Load the state map data 
states <- map_data("state")

# Determine the number of colleges in every state
college_summary <- college %>%
  group_by(state) %>%
  summarize(schools=n())

# Take a look at the result
college_summary
states

# Add the full state names to the college_summary tibble
college_summary <- college_summary %>%
  mutate(region=as.character(setNames(str_to_lower(state.name), state.abb)[as.character(state)]))

# Add DC back in
college_summary <- college_summary %>%
  mutate(region=ifelse(as.character(state)=="DC", "district of columbia",region)) 

# Join the college_summary and states tibbles
mapdata <- merge(states, college_summary, by="region")

# Plot a basic map
ggplot(mapdata) +
  geom_polygon(aes(x=long,y=lat,group=group)) +
  coord_map() +
  theme(plot.background=element_blank(), panel.background = element_blank(), axis.title=element_blank(), axis.ticks=element_blank(), axis.text=element_blank()) 


# Convert to a choropleth map by using the schools variable as the fill
ggplot(mapdata) +
  geom_polygon(aes(x=long,y=lat,group=group, fill=schools)) +
  coord_map() +
  theme(plot.background=element_blank(), panel.background = element_blank(), axis.title=element_blank(), axis.ticks=element_blank(), axis.text=element_blank()) 

# Change the color scheme
ggplot(mapdata) +
  geom_polygon(aes(x=long,y=lat,group=group, fill=schools)) +
  coord_map() +
  theme(plot.background=element_blank(), panel.background = element_blank(), axis.title=element_blank(), axis.ticks=element_blank(), axis.text=element_blank()) +
  scale_fill_gradient(low = "beige", high = "red")

states <- map_data("state")

# Plot the colleges on the map
ggplot(states) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat))

# Remove Alaska and Hawaii
college <- college %>%
  filter(state!="HI" & state!="AK")

# Replot the map
ggplot(states) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat))

# Change size based upon number of students
ggplot(states) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat, color=control, size=undergrads))

# Add some transparency
# Replot the map

california <- map_data(map="county", region="California")

college <- college %>%
  filter(state=="CA")

ggplot(california) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat, color=control, size=undergrads), alpha=0.6)

city_names <- c("Los Angeles", "San Diego", "San Jose", "San Francisco", "Fresno", "Sacramento")
locations <- geocode(city_names)
cities <- tibble (name=city_names, lat=locations$lat, lon=locations$lon)

# Label the cities
ggplot(california) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat, color=control, size=undergrads), alpha=0.6) +
  geom_text(data=cities, mapping=aes(x=lon, y=lat, label=name))

# Rename the legends
ggplot(california) +
  geom_polygon(mapping=aes(x=long,y=lat,group=group), color="grey", fill="beige") +
  coord_map() +
  theme(plot.background=element_blank(), 
        panel.background = element_blank(), 
        axis.title=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text=element_blank()) +
  geom_point(data=college, mapping=aes(x=lon, y=lat, color=control, size=undergrads), alpha=0.6) +
  geom_text(data=cities, mapping=aes(x=lon, y=lat, label=name)) +
  scale_size_continuous(name="Undergraduate Population") +
  scale_color_discrete(name="Institutional Control")
