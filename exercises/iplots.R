library(iplots)

######## example 1

data(mtcars)
cyl.f=factor(mtcars$cyl)
gear.f=factor(mtcars$gear)

ihist(mtcars$mpg)
ibar(mtcars$carb)
iplot(mtcars$mpg, mtcars$wt)
ibox(mtcars[c("qsec","disp","hp")]) # boxplots
ipcp(mtcars[c("mpg","wt","hp")])  # parallel coordinates
imosaic(cyl.f,gear.f) #mosaic plot

# pres Ctrl key and mouse over each point to get info

########## example 2

library(MASS)
data(Cars93)

# moasic plot
imosaic(data.frame(Cars93$AirBags,Cars93$Cylinders, Cars93$Origin))

# barcharts
ibar(Cars93$Cylinders)
ibar(Cars93$Cylinders, isSpine=T)

iplot.opt(isSpine=T)

# Bars can be reordered by <alt> and dragging bar into desired position

library(maptools)

imaps()


#parallel plots
ipcp(Cars93[c(4:8, 12:15, 17, 19:25)])

# boxplots
ibox(Cars93[4:6])
ibox(Cars93$Horsepower, Cars93$Cylinders)

# scatterplots
iplot(Cars93$Horsepower, Cars93$MPG.city)
ll=lowess(Cars93$Horsepower, Cars93$MPG.city)
ilines(ll)

iobj.rm()  # removes the last object

iplot.opt(ptDiam=5, col=unclass(Cars93$Cylinders))

# histograms
ihist(Cars93$Horsepower)
iplot.opt(anchor=25, binw=25)


#### adding regression line
ip=iplot(Cars93$EngineSize, Cars93$Horsepower)
ip + lm(Cars93$Horsepower~Cars93$EngineSize)

##### Timeseries data
data("EuStockMarkets")
iplot(EuStockMarkets[,1])


#### other functions
# create a dragbox and select points within rectangle

# select points
iset.selected()
sum(sign(iset.sleected()))/length(Cars93$Horsepower)

iset.select(Cars93$Horsepower >150)

# color brush
iplot.opt(col=unclass(Cars93$Cylinders))

# Objects
iplot(Cars93$EngineSize, Cars93$Horsepower)
subs=iset.selected() # select all but outliers
iabline(lm(Cars93$Horsepower ~ Cars93$EngineSize, subset=subs))



