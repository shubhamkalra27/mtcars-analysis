
#custom function to check and install packages
usePackage <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("rmarkdown","plyr","ggplot2")
usePackage(packages)


data(mtcars)
#importing data in a variable
cars <- mtcars
head(cars)

summary(cars)
View(cars)

# Changing classifying variables  from binary values to factor

cars$cyl <- factor(cars$cyl)
cars$vs <- factor(cars$vs)
cars$am <- factor(cars$am)
cars$gear <- factor(cars$gear)
cars$carb <- factor(cars$carb)



par(mfrow = c(1, 2)) 
#visualize two graphs in one horizontal length
# Add a Normal Curve (Thanks to Peter Dalgaard)
x <- cars$mpg 
h<-hist(x, breaks=10, col="cornflowerblue", xlab="Miles Per Gallon", 
        main="Histogram with Normal Curve") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

# Density Curve
plot(density(cars$mpg), xlab = "MPG", main ="Density Plot of MPG")

# find just numeric variables
nums <- sapply(cars, is.numeric)

# correlation matrix
pairs(cars[,nums], main ="Finding Correlation among Variables", panel=function(x,y) {
  points(x, y)
  abline(lm(y ~ x), col="red")
})

# Boxplot
transmission <- revalue(cars$am, c('0'="automatic", '1'="manual"))
qplot(transmission, mpg, data=cars, geom=c("boxplot"), 
      fill=am, main="Mileage by Transmission Type",
      xlab="Transmission Type", ylab="Miles per Gallon")

# t test

t.test(mpg~am, data = cars)

# linear model with just one predictor
model1 <- lm( mpg~am ,data=mtcars); summary(model1)

# step function

nullModel <- lm (mpg ~ 1 , data =cars) # model with no predictor variables.

fullModel <- lm (mpg ~ . , data = cars) # model with all variables added as predictor variables. 

bestModel <- step(fullModel, nullModel, direction = "both" , k=  log(nrow(cars))) #both direction BIC step model

bestModel$call  #display formula

summary(bestModel)
