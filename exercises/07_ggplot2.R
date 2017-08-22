### Quick plots qplot() function

library(ggplot2)

# create factors with value labels

mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5), labels=c("3gears","4gears","5gears"))
mtcars$am <- factor(mtcars$am,levels=c(0,1), labels=c("Automatic","Manual"))
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),labels=c("4cyl","6cyl","8cyl"))

                     
# 1.1 density plot
qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5),main="Distribution of Gas Milage", xlab="Miles Per Gallon",ylab="Density")

#1.2 scatterplot with facets
qplot(hp, mpg, data=mtcars, geom="point", color=am,size=I(3),xlab="Horsepower", ylab="Miles per Gallon")

qplot(hp, mpg, data=mtcars, geom="point", color=am, facets=gear~cyl, size=I(3),xlab="Horsepower", ylab="Miles per Gallon")

#1.3 Separate regressions of mpg on weight for each number of cylinders
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm", formula=y~x, color=cyl,main="Regression of MPG on Weight",xlab="Weight", ylab="Miles per Gallon")

#1.4 Boxplots of mpg by number of gears; observations(points) are overlayed and jittered
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"),fill=gear, main="Mileage by Gear Number", xlab="", ylab="Miles per Gallon")

### further ggplot2 plots

library(ggplot2)

# 1.1 x mapped to wt, y mapped to mpg and point geometry used
ggplot(mtcars) + 
  aes(x=wt, y = mpg) + 
  geom_point()

# 1.2 x mapped to wt and histogram geometry is used
ggplot(mtcars) + aes(x=wt) + geom_histogram(bins=10)

# 1.3 x mapped to cyl and bar geometry is used
ggplot(mtcars) + aes(x = factor(cyl)) + geom_bar()

# 1.4 x mapped to cyl, y mapped to mpg and boxplot geometry used
ggplot(mtcars) + aes(x = factor(cyl), y = mpg) + geom_boxplot(fill='green')

# 1.5 x mapped to wt, y mapped to mpg and point and line geometry used
ggplot(mtcars) + aes(x=wt, y = mpg) + geom_point() + geom_line()

# 2. x mapped to wt, y mapped to mpg, and color mapped to am
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am)) + geom_point()

# 3. x mapped to wt, y mapped to mpg, color mapped to am, shape mapped to cyl, size
# mapped to vs
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am), shape = factor(cyl),
                     size = factor(vs)) + geom_point()

# 4. To assign a constant value to an attribute, put it inside the geom 
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am), shape = factor(cyl)) +
                    geom_point(size = 3)

# 5. To change x and y scale use appropriate scale command
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am), shape = factor(cyl)) +
  geom_point(size = 3) + scale_x_continuous(limits=c(1,6)) +
  scale_y_continuous(limits=c(5,40))

# 6. Setting legend properties using guide
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am), shape = factor(cyl)) +
  geom_point(size = 3) + guides(col = guide_legend('am'), shape=guide_legend('cyl'))

# 7. Setting axis properties using theme
ggplot(mtcars) + aes(x=wt, y = mpg, col = factor(am), shape = factor(cyl)) +
  geom_point(size = 3) + guides(col = guide_legend('am'), shape=guide_legend('cyl')) +
  theme(axis.text=element_text(size = 15), axis.title=element_text(size=20))


## 8. Plotting subset of data in a separate panel: Facetting
ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  facet_wrap( ~ cyl)

# multiple boxplot
ggplot(mtcars)+aes(x=factor(gear), y=mpg)+
  geom_boxplot(col="red")+
  geom_jitter(col="blue")

ggplot(mtcars)+aes(x=factor(gear), y=mpg)+
  geom_boxplot(col="red")+
  geom_jitter(col="blue")+
  facet_wrap(~factor(am))

#multiple barplot
ggplot(mtcars) +aes(x=mpg, fill=factor(gear))+
  geom_bar()

ggplot(mtcars) +aes(x=mpg, fill=factor(gear))+
  geom_bar()+
  facet_wrap(~factor(vs))

ggplot(iris) + aes(x=Sepal.Length, fill=Species)+
  geom_bar()

## waterfall chart

# sample data

balance=data.frame(id=seq(1,8), desc=c("Start cash", "Sales","Refunds","Payouts","Losses","Wins","Contracts","End cash"),
                   type=c("net","in","out","out","out","in","in","net"),
                   start=c(0,2000,5400,4300,4200,-2400,1400,2800),
                   end=c(2000,5400,4300,4200,-2400,1400,2800,0),
                   amount=c(2000,3400,-1100,-10,-6600,3800,1400,2800))

ggplot(balance, aes(desc, fill=type)) + geom_rect(aes(x=desc, xmin=id -0.45, xmax=id + 0.45, ymin=end, ymax=start))



## Bubble plot

ggplot(mtcars, aes(carb,gear, size=mpg, label=vs)) + geom_point(colour="red") + geom_text(size=3) + xlab("mtcars CARB") + ylab("mtcars GEAR")

ggplot(mtcars, aes(wt,mpg)) + geom_point(aes(size=qsec))


## Violin plot
ggplot(iris, aes(x=Species, y=Sepal.Width)) + geom_violin(trim=F)


#### heat maps
ggplot(mtcars, aes(x=wt, y=gear, group=gear)) + geom_tile(aes(fill=mpg)) + scale_fill_gradient(low="white", high="red")

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, group=Species)) + geom_tile(aes(fill=Petal.Length)) + scale_fill_gradient(low="white", high="red")


################### Challenge

# use the heart.csv dataset
# plot each of the above plots including the numerical and categorical variables