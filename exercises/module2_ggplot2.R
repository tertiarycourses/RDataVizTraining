# Module 2 Data Visualization Using ggplots2

# Load the Tidyverse
library(tidyverse)

# Read the college dataset
college <- read_csv('http://672258.youcanlearnit.net/college.csv')

# Take a look at the data
summary(college)

# Convert state, region, highest_degree, control, and gender to factors
college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region), city=as.factor(city),
         highest_degree=as.factor(highest_degree),
         control=as.factor(control), gender=as.factor(gender))

# Take a look at the data
summary(college)

# I need to tell ggplot what data to use
ggplot(data=college)

# And then give it some instructions using the grammar of graphics.
# Let's build a simple scatterplot with tuition on the x-axis and average SAT score on the y axis
ggplot(data=college) + geom_point(size=3) + aes(x=tuition, y=sat_avg)

# Ex Scatter Plot
ggplot(data=mtcars) + geom_point(size=3) + aes(x=wt, y=mpg) 

# Let's try representing a different dimension.  
# What if we want to differentiate public vs. private schools?
# We can do this using the shape attribute
ggplot(data=college) + geom_point(size=3) + aes(x=tuition, y=sat_avg, shape=control, color=control)

# Add More Attributes
ggplot(data=college) + geom_point() + aes(x=tuition, y=sat_avg, color=control, size=undergrads)

# Ex: Scatter Plot
ggplot(data=mtcars) + geom_point() + aes(x=mpg,y=hp,color=factor(am),size=factor(cyl))

# And, lastly, let's add some transparency so we can see through those points a bit
# Experiment with the alpha value a bit.
ggplot(data=college) + geom_point() + aes(x=tuition, y=sat_avg, color=control, size=undergrads,alpha=1/100)

# Line Plot
ggplot(data=college) + geom_line() + geom_point() + aes(x=tuition, y=sat_avg, shape=control, color=control)

# Add Fitting Line
ggplot(data=college) + geom_smooth() + geom_point() + aes(x=tuition, y=sat_avg, shape=control, color=control)
ggplot(data=college) + geom_smooth(se=FALSE) + geom_point() + aes(x=tuition, y=sat_avg, shape=control, color=control)

# How many schools are in each region?
# This calls for a bar graph!
ggplot(data=college) + geom_bar() + aes(x=region)


# Stacked Barplot
ggplot(data=college) + geom_bar() + aes(x=region, fill=control)

# Ex: Barplot
gs <- read_csv('./data/gs.csv')
ggplot(data=gs) + geom_bar() + aes(x=factor(Category),fill=Segment) 

ggplot(data=gs) + geom_col() + aes(x=factor(Category),y=Sales, fill=Segment)


# How about average tuition by region?
# First, I'll use some dplyr to create the right tibble
college %>%
  group_by(region) %>%
  summarize(average_tuition=mean(tuition))

# Piping data to ggplot2
college %>%
  group_by(region) %>%
  summarize(avg_tuition=mean(tuition)) %>%
  ggplot() + geom_col() + aes(x=region, y=avg_tuition)

# Ex: data piping

gs %>%
  group_by(Region) %>%
  summarize(avg_sales=mean(Sales)) %>%
  ggplot() + geom_col() + aes(x=Region,y=avg_sales,fill=Region)

# Histogram
ggplot(data=college) + geom_histogram(binwidth=1000) + aes(x=undergrads,origin=0)

# Ex: Histogram 
ggplot(data=gs) + geom_histogram(bins=10,fill='red') +
  aes(x=Discount)

# Boxplot
ggplot(data=college) + geom_boxplot(fill='green') + aes(x=control, y=tuition)

ggplot(data=college) + geom_boxplot(fill='red') + geom_jitter(col="blue") + aes(x=control, y=tuition)

# Ex
ggplot(mtcars)  + geom_boxplot(fill='green') + geom_jitter(col="blue") + aes(x=factor(cyl), y=mpg)

