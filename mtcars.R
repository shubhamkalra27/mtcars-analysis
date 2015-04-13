
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


#==================== Analysis ends here==========================
'here are a few more things you can do during the analysis '

# Check for model assumptions 
plot(bestModel)


# use AIC criterion on the step function. 
model_AIC <- step(fullModel, nullModel, direction = "both" , k=2) #both direction AIC step model
summary(model_AIC) # see how different it is from bestModel


# Compare the AIC model with our exisiting BIC model. 
anova(model_AIC, bestModel)


# Interaction terms helps to understand the relationships among the variables. 
# adding a few interaction terms looking at the correlation matrix. 

model_with_interaction_terms <- lm(mpg ~ am + wt+ qsec + cyl + hp 
                 + disp:hp + drat:disp + drat:wt +disp:wt + 
                   hp:qsec ,   data = cars)


summary(model_with_interaction_terms)

' remember this is at a loss of degrees of freedom. 
Lets run a step function on the new model with interactions
'

model_step_interactions <- step(model_with_interaction_terms, model0, 
                  direction = "both", k=  log(nrow(cars)) )

summary(model_step_interactions)

model_step_interactions$call

# lm(formula = mpg ~ wt + qsec + disp:drat + wt:drat + wt:disp, data = cars)

# we see that in above model, transmission has no say in the mileage of the vehicle. 
# adj R sq is 0.86 

# how different is this model statistically from our bestModel?
anova(bestModel, model_step_interactions)
