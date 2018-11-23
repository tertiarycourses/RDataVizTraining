# Module 1 Basic Plots

# Load data

data(mtcars)

# Scatter plot

plot(mtcars$mpg, mtcars$qsec) 
plot(mtcars$mpg, mtcars$qsec,main='MTCars',xlab='mpg',ylab='qsec')

# Adding trendline to scatter plot

plot(mtcars$mpg,mtcars$hp)
m=lm(hp~mpg,data=mtcars) # linear regression
abline(lm, lty=2)   # abline - add straight line to plot

# Partition screen

par(mfrow=c(2,2))   # split a screen into 2 by 2 (4 parts)
par(mfrow=c(1,1))   # restore screen to normal 1 plot

# Scatter Plot by Relationship
plot(mpg~hp, data=mtcars)
plot(~mpg+qsec+wt, data=mtcars)
pairs(mtcars)

# Bubble plot
symbols(mtcars$hp, mtcars$mpg, circles=mtcars$cyl,bg='red',inches = 0.25)

# Ex: Scatter plot

data(iris)
par(mfrow=c(1,2))
plot(iris$Petal.Length~iris$Sepal.Length)
lm=lm(iris$Petal.Length~iris$Sepal.Length)
abline(lm)
plot(iris$Petal.Length~iris$Petal.Width)
lm=lm(iris$Petal.Length~iris$Petal.Width)
abline(lm)

# Barplot

par(mfrow=c(1,1))
cyl = table(mtcars$cyl)
barplot(cyl,col='yellow')
barplot(cyl,col='yellow',horiz=T)

# Stack Barplot

stack = table(mtcars$cyl,mtcars$am)
barplot(stack,col=c("blue","red", "green"),xlab="am", ylab="cyl")

# Group Barplot
barplot(stack,col=c("darkblue","red", "green"),xlab="am", ylab="cyl",beside=T)

# Histogram
hist(mtcars$mpg,breaks=6,col='yellow')

# Pie Plot 
pie(cyl,col=c('red','green','blue'))

# Ex: Bar plot
species = table(iris$Species)
par(mfrow=c(2,1))
barplot(species,col=c('red','green','blue'))
pie(cyl,col=c('red','green','blue'))

# Boxplot

boxplot(mtcars$mpg~mtcars$cyl,xlab='cyl',ylab='mpg')
boxplot(mtcars$mpg~mtcars$cyl,xlab='cyl',ylab='mpg',horizontal=T,notch=T)

# Overlay data to Boxplot

boxplot(mtcars$mpg~mtcars$cyl,xlab='cyl',ylab='mpg')
stripchart(mtcars$mpg~mtcars$cyl,vertical=T,add=T)

# Ex Boxplot

boxplot(iris$Sepal.Length~iris$Species,xlab='Species',ylab='Sepal Length')
stripchart(iris$Sepal.Length~iris$Species,vertical=T,add=T)


# add points to the boxplot
boxplot(Sepal.Length ~ Species, data = iris, outpch = NA) 
stripchart(Sepal.Length ~ Species, data = iris, 
           vertical = TRUE, method = "jitter", 
           pch = 21, col = "maroon", bg = "bisque", 
           add = TRUE) 

# Dendrogram

hc=hclust(dist(mtcars))    
hcd=as.dendrogram(hc)
plot(hcd)
plot(hcd, type="triangle")    # triangle type

## plot dendogram with some cuts

# par(mfrow=c(2,1))
# plot(cut(hcd, h=75)$upper, main="Upper tree of cut at h=75")
# plot(cut(hcd, h=75)$lower[[2]], main="2nd branch of lower tree with cut at h=75")
# par(mfrow=c(1,1))

# Heat Map

data = as.matrix(mtcars[ ,4:8])
heatmap(data)

# Tree Map

install.packages("treemap")
library(treemap)
treemap(mtcars,index=c("cyl","vs","am"),vSize="mpg")


# Violin Plot

library(vioplot)
vioplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width, col="grey")

# Vbean plot
library(beanplot)
beanplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width)


# Waterfall Plot

library(waterfall)
data(rasiel) # example dataset in waterfall package
waterfallchart(value~label, data=rasiel, groups=rasiel$subtotal, main="P&L waterfall")
data(jaquith)
waterfallchart(jaquith$factor ~ jaquith$score, jaquith)


# Dotplot

dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="mtcars dotplot", xlab="mpg")

# Mosaic plots

mosaicplot(mtcars$cyl~mtcars$vs, shade=TRUE, legend=TRUE, main="Mosaic mtcars")
data("HairEyeColor")
mosaicplot(HairEyeColor, col=terrain.colors(2), shade=T)


# Correlation plot
library(corrplot)
numericalVars=UScereal[ ,2:10]
corrMat=cor(numericalVars)
corrplot(corrMat, method="ellipse")


