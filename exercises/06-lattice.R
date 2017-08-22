library(lattice)

data(mtcars)

mtcars2=mtcars
mtcars2$gear=as.factor(mtcars2$gear)
mtcars2$cyl=as.factor(mtcars2$cyl)


##### kernel density plot
densityplot(~mpg, data=mtcars2, main="DensityPlot", xlab="Miles per Gallon")

##### kernel density plot by factor level
densityplot(~mpg|cyl, data=mtcars2, main="DensityPlot by cylinders",
            xlab="Miles per Gallon")


densityplot(~mpg|cyl, data=mtcars2, main="DensityPlot by cylinders",
            xlab="Miles per Gallon", layout=c(1,3))

###### boxplot for each combination of 2 factors
bwplot(cyl~mpg|gear, data=mtcars2, ylab="Cylinders", xlab="Miles per gallon",
       main="Milage by cylinders and gear", layout=c(1,3))

##### scatterplots for each combination of two factors
xyplot(mpg~wt|cyl*gear, data=mtcars2, main="Scatterplots by Cylinders and Gear",
       ylab="Miles per Gallon", xlab="Car Weight")

xyplot(mpg~wt, data=mtcars2, group=cyl, auto.key=T)

####### 3d scatterplot by factor level
cloud(mpg~wt*qsec|cyl, data=mtcars2, main="3D scatterplot by cylinders")

cloud(mpg~wt*qsec, data=mtcars2, group=cyl, auto.key=T)

####### dotplot for each combination of two factors
dotplot(cyl~mpg|gear, data=mtcars2, main="dotplot by number of Gears and Cylinders",
        xlab="Miles Per Gallon")

dotplot(cyl~mpg, data=mtcars2, main="dotplot by number of Gears and Cylinders",
        xlab="Miles Per Gallon", group=gear, auto.key=T)

###### scatterplot matrix
splom(mtcars2[c(1,3,4,5,6)], main="mtcars data")

