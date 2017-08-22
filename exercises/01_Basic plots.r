####################### Partition screen

par(mfrow=c(2,2))   # split a screen into 2 by 2 (4 parts)

par(mfrow=c(1,1))   # restore screen to normal 1 plot


# for this course we will use the mtcars and iris and several other dataset
# i have also supplied you with a heart dataset to practise with

data(mtcars)
data(iris)

####################### ScatterPlot

plot(mtcars$mpg, mtcars$qsec)  # we key in column names we want to set as x and y axis
plot(iris$Sepal.Length, iris$Sepal.Width)



### adding details
library(MASS)
plot(Cars93$Price, Cars93$Max.Price, pch=17, col="red")
points(Cars93$Price, Cars93$Min.Price,pch=16, col="blue")
abline(a=0, b=1, lty=2)

### empty plot then add details
# "n" option to create an empty plot
max_hp=max(Cars93$Horsepower, mtcars$hp)
max_mpg=max(Cars93$MPG.city, Cars93$MPG.highway, mtcars$mpg)

plot(Cars93$Horsepower, Cars93$MPG.city,
     type="n",                              # the "n" puts no points > empty plot
     xlim=c(0, max_hp),
     ylim=c(0, max_mpg),
     xlab="HorsePower",
     ylab="Miles per galon")

points(mtcars$hp, mtcars$mpg, pch=1)  # add open circles to plot
points(Cars93$Horsepower, Cars93$MPG.city, pch=15) # add open squares to plot
points(Cars93$Horsepower, Cars93$MPG.highway, pch=6) # add open triangles to plot

# adding trend lines
linear_model=lm(Gas~Temp, data=whiteside)
plot(whiteside$Temp, whiteside$Gas)
abline(linear_model, lty=2)


# scatterplot to check if linear relationship
library(car)
scatterplot(mpg ~ qsec, data=mtcars)

# scatterplot matrix
library(car)
scatterplotMatrix(~mpg+qsec+wt, data=mtcars)

# simple scatterplot
pairs(mtcars)

####################### Barplot

barplot(mtcars$qsec)
barplot(iris$Sepal.Width)

# if we need to visualize the table
barplot(mtcars[ ,2], names.arg=rownames(mtcars)); lines(density(mtcars[ ,2]))

#if need stacked bar plot
counts=table(mtcars[ ,10], mtcars[ ,2])
barplot(counts, main="plot of mtcars", xlab="gear", ylab="mpg", col=c("darkblue","red", "green"),
        legend=rownames(counts))


# if need horizontal barplot
counts=table(mtcars[ ,10], mtcars[ ,2])
barplot(counts, main="plot of mtcars", xlab="gear", ylab="mpg", col=c("darkblue","red", "green"),
        horiz=T,legend=rownames(counts))

#if we need a grouped bar plot
counts=table(mtcars[ ,10], mtcars[ ,2])
barplot(counts, main="plot of mtcars", xlab="gear", ylab="mpg", col=c("darkblue","red", "green"),
        beside=T,legend=rownames(counts))

# reorder the data
data2 = mtcars[order(mtcars[,2],decreasing=T),]
barplot(data2[,10],names.arg=data2[,2])

###################### Line Plot

data("EuStockMarkets")

plot(EuStockMarkets[,1], type="l", xlab="time", ylab="Price")

plot(EuStockMarkets[,1][1:10], type="l") # this enables zoom in


# multiple line plot
plot(mtcars$mpg, mtcars$hp) # this will create the plot with dots
lines(mtcars$mpg, mtcars$hp, type="b", lwd=1.5)  # we connect dots with line

# try all the options below

#type	description
# p	points
# l	lines
# o	overplotted points and lines
# b, c	points (empty if "c") joined by lines
# s, S	stair steps
# h	histogram-like vertical lines
# n	does not produce any points or line


###################### Histogram

hist(iris[,1], breaks=20, main="Histogram")  # we can set the breaks

# we can adjust the scale of the x and y axis
hist(iris[,1], breaks=20, xlim=c(0,10), ylim=c(0,25))

# add the breaks ourselves
hist(iris[,1], breaks=c(0,3,6,9,12,15,18))

# add color
hist(iris[,1], col=c("blue","green","red"))

# normalized histogram
truehist(iris[,1])
lines(density(iris[,1]))  # adding a density curve

##################### Pie Chart

counts=table(mtcars[ ,10], mtcars[ ,2])
pie(counts)

##################### Boxplot

# we must split a numeric by a categorical variable
boxplot(iris$Sepal.Length~iris$Species)

boxplot(iris$Sepal.Length~iris$Species, horizontal=TRUE)  # horizontal version

# if we want to zoom into a certain range
boxplot(iris$Sepal.Length~iris$Species, horizontal=TRUE, ylim=c(4,6))   


# add a notch to the boxplot and other features
boxplot(iris$Sepal.Length,
        main = "Iris Sepal Length",
        xlab = "Sepal.Length",
        ylab = "Sepal",
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
)

# add points to the boxplot
boxplot(Sepal.Length ~ Species, data = iris, outpch = NA) 
stripchart(Sepal.Length ~ Species, data = iris, 
           vertical = TRUE, method = "jitter", 
           pch = 21, col = "maroon", bg = "bisque", 
           add = TRUE) 



#################### Bubble plot

# col 1 and col2 should be categorical not continous, col3 should be continous
# in this example we are measuring col3 > we simplify the diagram by converting area to radius

symbols(mtcars$cyl, mtcars$am, circles=sqrt(mtcars$mpg/ pi ), 
        inches=0.35, fg="white", bg="red", xlab="cyl", ylab="am")
text(mtcars$cyl, mtcars$am, mtcars$mpg, cex=0.5) # col3 is the labeller, we can change this


symbols(Cars93$Horsepower,Cars93$MPG.city, circles=Cars93$Cylinders, inches=0.2,fg="white", bg="red")


radius=sqrt(mtcars$qsec/pi)
symbols(mtcars[,6], mtcars[,1], circles=mtcars$qsec,inches=0.15, fg="grey", bg="black", xlab="Wt", ylab="Miles per gallon")
text(mtcars[,6], mtcars[,1], mtcars[,7], cex=0.5, col="white")


################### Violin Plot
# combination of boxplot and (doubled) kernel density plot
# useful for comparing multiple data groups

library(vioplot)
vioplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width, col="grey")

###################Vbean plot
library(beanplot)
beanplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width)


################### waterfall Plot

# useful for finance and accounting
# col2 contains the values that go up(+ve) or down(-ve), col1 is the names and col3 is the groupings

library(waterfall)
data(rasiel) # example dataset in waterfall package

waterfallchart(value~label, data=rasiel, groups=rasiel$subtotal, main="P&L waterfall")

data(jaquith)
waterfallchart(jaquith$factor ~ jaquith$score, jaquith)


################# strip chart
stripchart(iris$Sepal.Width, method="stack", offset=.5, at=.1)


################# dotplot

dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="mtcars dotplot", xlab="mpg")


############### mosaic plots

mosaicplot(mtcars$cyl~mtcars$vs, shade=TRUE, legend=TRUE, main="Mosaic mtcars")

data("HairEyeColor")
mosaicplot(HairEyeColor, col=terrain.colors(2), shade=T)


################ correlation plot
library(corrplot)
numericalVars=UScereal[ ,2:10]
corrMat=cor(numericalVars)
corrplot(corrMat, method="ellipse")


################### Challenge

# use the heart.csv dataset and the cocaCola.csv dataset (time series)
# plot each of the above plots including the numerical and categorical variables

