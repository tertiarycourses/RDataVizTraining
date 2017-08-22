################################ Sunflower Plot
# Multiple points are plotted as "sunflowers" with multiple leaves 
#("petals") such that overplotting is visualized instead of accidental and invisible

sunflowerplot(iris[ ,3:4], cex=.2, cex.f=1, size=.035, seg.lwd=.8)
# can adjust size of points and other areas

################################ Network Plot

library(igraph)

relations=data.frame(from=c("Bob","Cecil","Cecil","David","David","Emmett"),
                      to=c("Alice","Bob","Alice","Alice","Bob","Alice"),
                     weights=c(4,5,5,2,1,1))

g=graph.data.frame(relations, directed=T)

plot(g, edge.width=E(g)$weight)


################################ Radial Plot
# useful for visualizing distribution of one variable
library(plotrix)

iris22=iris[20:30,c(1,5)]
iris22

radial.plot(iris22$Sepal.Length, labels=iris22$Species, rp.type="p", main="radar chart", 
  radial.lim=c(0,10), line.col="blue")
 
#if we need to convert a table into data frame
# as.data.frame.matrix


#####################################  hexbins
# useful when data overlaps
library(hexbin)
ajay=hexbin(iris$Petal.Length, iris$Sepal.Length, xbins=30)
plot(ajay)


################### Challenge

# use the heart.csv dataset
# plot each of the above plots including the numerical and categorical variables