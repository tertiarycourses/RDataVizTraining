############################### Simple Dendrogram

hc=hclust(dist(mtcars))    # prepare heirarchical cluster
plot(hc)                   # plot dendogram

plot(hc, hang=-1)          # labels at same level

## alternative dendograms

hcd=as.dendrogram(hc)
plot(hcd)

plot(hcd, type="triangle")    # triangle type

## plot dendogram with some cuts

par(mfrow=c(2,1))
plot(cut(hcd, h=75)$upper, main="Upper tree of cut at h=75")
plot(cut(hcd, h=75)$lower[[2]], main="2nd branch of lower tree with cut at h=75")
par(mfrow=c(1,1))

## plot dendogram with colours

library(dendextend)
d1=color_branches(hcd, k=5, col=c(2,1,1,4,1))
plot(d1)
d2=color_branches(d1,k=5)
plot(d2)


############################### Heat Map

# convert dataframe into matrix first
data2=as.matrix(iris[ ,1:4])
heatmap(data2)

data3=as.matrix(mtcars[ ,4:8])
heatmap(data3)


# we can alsoa scale the data
data2=scale(mtcars)
heatmap(data2)


############################### Three dimensional Heat Map 

library(d3heatmap)
d3heatmap(mtcars, scale="column")

d3heatmap(mtcars, scale="column", dendogram="none", color="Blues")
#remove dendogram and change to blue color

d3heatmap(mtcars, colors = "Blues", scale = "col", dendrogram = "row", k_row = 3)
# cluster the dendogram into 3 clusters (different colors)


############################### Tree Map

library(treemap)

mtcars222=mtcars
mtcars222$carb=as.factor(mtcars222$carb)


treemap(mtcars222,                        # dataframe object
        index=c("cyl","vs","am"),         # list of categorical variables
        vSize="mpg",                      # quantitative variable
        type="index",                     # sets organization and color scheme
        palette="Greens",                 # selects color palatte from RColorBrewer
        title="mtcars treemap 1",         # title
        fontsize.title = 14)              # fontsize


# different color > red
treemap(mtcars222,                        # dataframe object
        index=c("cyl","vs","am"),         # list of categorical variables
        vSize="mpg",                      # quantitative variable
        type="index",                     # sets organization and color scheme
        palette="Reds",                 # selects color palatte from RColorBrewer
        title="mtcars treemap 1",         # title
        fontsize.title = 14)              # fontsize


# color by categorical label
treemap(mtcars222,                           # dataframe object
        index=c("cyl","vs","am"),         # list of categorical variables
        vSize="mpg",                      # quantitative variable
        vColor="carb",                    # this is a categorical label
        type="categorical",               # sets organization and color scheme
        palette="Set1",                   # selects color palatte from RColorBrewer
        title="mtcars treemap 2",         # title
        fontsize.title = 14)              # fontsize


### alternative way

library(portfolio)
map.market(id=iris$Sepal.Length, area=iris$Sepal.Width, group=iris$Species,
           color=iris$Petal.Width, main="Iris Treemap")

map.market(id=mtcars$mpg, area=mtcars$hp, group=mtcars$cyl,
           color=mtcars$qsec, main="Mtcars Treemap")


data1=read.csv("http://datasets.flowingdata.com/post-data.txt")
View(data1)
map.market(id=data1$id, area=data1$views, group=data1$category,
           color=data1$comments, main="FlowingData Map")



################### Challenge

# use the heart.csv dataset
# plot each of the above plots including the numerical and categorical variables
# heatmaps
# dendograms