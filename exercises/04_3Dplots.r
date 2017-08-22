#########################  RGL plots

## Load data
dat <- read.table(header = TRUE, text = "
y   x1  x2   gps
12.37   2.23    9.66    gp1
12.66   2.57    8.94    gp2
12      3.87    4.4     gp3
11.93   3.1     6.64    gp1
11.06   3.39    4.91    gp2
13.03   2.83    8.52    gp3
13.13   3.02    8.04    gp4
11.44   2.14    9.05    gp1
12.86   3.04    7.71    gp2
10.84   3.26    5.11    gp3
11.2    3.39    5.05    gp1
11.56   2.35    8.51    gp2
10.83   2.76    6.59    gp3
12.63   3.9     4.9     gp4
12.46   3.16    6.96    gp4
")


## Scatter plot
library(rgl)
with(data = dat,
     plot3d(x = x1,
            y = x2,
            z = y,
            type = "s",  # s_phere
            col = "red",
            size = 2            
            )
     )

# Plane
x <- 1:5/10
y <- 1:5
z <- x %o% y
z <- z + .2*z*runif(25) - .1*z


library(rgl)
persp3d(x, y, z, col="skyblue")


###### car graphics
library(rgl)
library(car)

## assign the columns
x1=dat$x1
x2=dat$x2
y=dat$y

car1=scatter3d(x1,x2,y, data=dat,
               type="p",
               size=4,
               xlab="xaxis",
               ylab="yaxis",
               zlab="zaxis",
               surface=T)

car2=scatter3d(x1,x2,y, data=dat,
               type="p",
               size=4,
               xlab="xaxis",
               ylab="yaxis",
               zlab="zaxis",
               surface=T,
               fit="smooth")

car3=scatter3d(x1,x2,y, data=dat,
                    type="p",
                    size=4,
                    xlab="xaxis",
                    ylab="yaxis",
                    zlab="zaxis",
                    surface=F,
                    grid=F,
                    ellipsoid = T,
                    axis.col=c("black","black","black"))


scatter3d(iris[,1],iris[,2],iris[,3])



####### lattice graphics

#wireframe
library(lattice)
p=wireframe(y ~ x1 * x2, data=dat)

npanel <- c(4, 2)
rotx <- c(-50, -80)
rotz <- seq(30, 300, length = npanel[1]+1)
update(p[rep(1, prod(npanel))], layout = npanel,
       panel = function(..., screen) {
         panel.wireframe(..., screen = list(z = rotz[current.column()],
                                            x = rotx[current.row()]))
       })


wireframe(volcano, shade=T, aspect=c(61/87, 0.4), lightsource=c(10,0,10))


# cloud
library(lattice)
library(car)

# box around the plot
cloud(y~x1+x2, data=dat)


# to remove the box
par.set=list(axis.line=list(col="transparent"), clip=list(panel="off"))

cloud(y~x1+x2, data=dat,
      xlab="xaxis",
      ylab="yaxis",
      zlab="zaxis",
      main="cloud",
      pch=16,
      par.settings=par.set,
      groups= gps,
      aspect=c(1,1),
      panel.aspect=1,
      screen=list(z=50, x=-50))



# seperate wireframes
cloud(Sepal.Length~Petal.Length*Petal.Width|Species, 
      data=iris, 
      screen=list(x=-90, y=70), 
      distance=.4,
      zoom=.6) 

# single wireframe
cloud(Sepal.Length~Petal.Length*Petal.Width, 
       data=iris, 
       screen=list(x=-90, y=70), 
        distance=.4,
        zoom=.6)



########################### basic 3D ploty

library(plotly)
p <- plot_ly(z = ~volcano) %>% add_surface()   # volcano is a prebuild dataset
p


############################# 3d scatterplot

library(rgl)

plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=1, lit=F, box=F,
      col=c("red","blue","green"), expand=1, xlab="Weight", ylab="Engine Disp", zlab="Mileage",
       main="Car weight VS Engine displacement VS mileage", sub="3Dplot")


# can click, rotate, drag and so on


#### saving the plot

rgl.snapshot('3dplot.png', fmt='png')



library(scatterplot3d)
library(car)

mtcarsmatrix=as.matrix(mtcars)

x1=mtcarsmatrix[,1]   #mpg
y1=mtcarsmatrix[,3]   #disp
z1=mtcarsmatrix[,5]   #drat

sp1=scatterplot3d(x1,y1,z1)

sp2=scatterplot3d(x1,y1,z1, pch=16, highlight.3d = T)


# adjust the angle
sp3=scatterplot3d(x1,y1,z1, pch=16,  highlight.3d = T, angle=120)

sp3.1=scatterplot3d(x1,y1,z1, pch=16,  highlight.3d = T, angle=250)

# adding height lines

sp4=scatterplot3d(x1,y1,z1, pch=16,  highlight.3d = T, angle=120, type='h')

sp4.1=scatterplot3d(x1,y1,z1, pch=16,  highlight.3d = T, angle=250, type='h')



########################### 3d pie charts

library(plotrix)

library(MASS)
data(survey)
tbl = table(survey$Smoke, survey$Exer) 
tbl

lbs=c("car1","car2","car3","car4","car5")

pie3D(tbl, labels=lbs, col=c("red","blue"), main="mpg VS am", explode=0.3)

# box()  # if we want a box around our chart
############################ 3d Histogram

library(plot3D)
library(MASS)
data(survey)
tbl = table(survey$Smoke, survey$Exer) 
tbl

hist3D(z=tbl, border="black")

## plot as 2d heatmap
image2D(z=z, border="black")


############################### 3d contour plots
x=seq(-10,10, length=30)
y=x
f=function(x,y){
  r=sqrt(x^2 + y^2)
  10*sin(r)/r
}
z=outer(x,y,f)

persp(x,y,z, theta=30, phi=30, expand=0.5, col="lightblue")

library(rgl)
persp3d(x,y,z, theta=30, phi=30, expand=0.5, col="lightblue")



################### Challenge

# use the heart.csv dataset and the iris dataset
# plot each of the above plots including the numerical and categorical variables