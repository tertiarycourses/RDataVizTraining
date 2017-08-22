library(ggvis)
library(dplyr)

mtcars %>% ggvis(~disp,~mpg) %>% layer_points()
# plot mtcars dataset disp vs mpg

# points and smooths
mtcars %>% ggvis(~wt,~mpg, fill:="blue") %>% layer_points()   # blue points
mtcars %>% ggvis(~wt,~mpg) %>% layer_smooths()   # smooths
mtcars %>% ggvis(~wt,~mpg) %>% layer_points() %>% layer_smooths()   # points & smooth

faithful %>% ggvis(~waiting, ~eruptions,
                 size=~eruptions, opacity:=0.5,
                 fill:="blue", stroke:="black", shape:="cross") %>% layer_points()


# bars
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()
# map fill property to temperature variable
pressure %>% ggvis(~temperature, ~pressure, fill=~temperature) %>% layer_points()
# map size property to pressure varaible
pressure %>% ggvis(~temperature, ~pressure, size=~pressure) %>% layer_points()

#lines
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
pressure %>% ggvis(~temperature, ~pressure,
                   stroke:="red", strokeWidth:=2, strokeDash :=6) %>% layer_lines()

# path
pressure %>% ggvis(~temperature, ~pressure, fill:="darkorange") %>% layer_paths()

#Histograms
faithful %>% ggvis(~waiting) %>% layer_histograms(width=5)

#density plot
faithful %>% ggvis(~waiting, fill:="green") %>% layer_densities()


########################### interactive plots ###################################3

### 7 input widgets

#input_checkbox()
#input_checkboxgroup()
#input_numeric()
#input_radiobuttons()
#input_select()
#input_slider()
#input_text()

# select box
faithful %>% ggvis(~waiting, ~eruptions, fillOpacity:=0.5,
                   shape:=input_select(label="Choose shape:",
                                       choices=c("circle","square","cross",
                                                 "diamond","triangle_up",
                                                 "triangle_down")),
                   fill:=input_select(label="Choose color:",
                                      choices=c("black","red","blue","green")))%>%
  layer_points()

# select box that returns variable names
mtcars %>% ggvis(~mpg, ~wt,
                 fill:=input_select(label="Choose fill variable:",
                                   choices=names(mtcars), map=as.name)) %>%
  layer_points()


#radio buttons

mtcars %>% ggvis(~mpg, ~wt, fill:=input_radiobuttons(label="Choose colour:",
                                                     choices=c("black","red",
                                                               "blue","green")))%>%
  layer_points()


# text
mtcars %>% ggvis(~mpg, ~wt, fill:=input_text(label="Choose color:",
                                             value="blue"))%>% layer_points()
# you can change the value in the text box to "red", "green" and so on ....



# numeric
mtcars %>% ggvis(~mpg) %>% layer_histograms(width=input_numeric(label="Choose a binwidth:",
                                                              value=1))

# slider
mtcars %>% ggvis(~mpg) %>% layer_histograms(width=input_slider(label="Choose a binwidth:",min=1, max=20))

# input select
mtcars %>% ggvis(x=~mpg, y=input_select(label="Choose what to plot:",
                                        choices=names(mtcars),
                                        selected="cyl",
                                        map=as.name))%>%
  layer_points()


#instead of names(mtcars) we can choose:   choices=c('gear'...etc)


# double input select:

mtcars %>% ggvis(x=input_select(label="Choose x-axis to plot:",
                                  choices=names(mtcars),
                                  selected="gear",
                                  map=as.name), 
                y=input_select(label="Choose y-axis to plot:",
                                        choices=names(mtcars),
                                        selected="gear",
                                        map=as.name))%>%layer_points()





################### Challenge

# use the heart.csv dataset
# plot each of the above plots including the numerical and categorical variables

# construct interactive plots as well