install.packages("rmarkdown")
library("rmarkdown")

??knitr
data(mtcars)
cars <- (mtcars)

cars$cyl <- factor(cars$cyl)
cars$vs <- factor(cars$vs)
cars$am <- factor(cars$am)
cars$gear <- factor(cars$gear)
cars$carb <- factor(cars$carb)


t.test(mpg~am, data = mtcars)

names(mtcars)

View(mtcars)

model0 <- lm(mpg ~ 1, data = cars)
model <- lm( mpg~am ,data=mtcars)

plot(model)

summary(model)


model2 <- lm( mpg~ . ,data=cars)

summary(model2)

model3 <- step(model2, model0, direction = "both")
par(mfrow = c(2,2))
plot(model3)

summary(model3)





library(plyr)
library(ggplot2)
# Rename the levels of transmission types
transmission <- revalue(cars$am, c('0'="automatic", '1'="manual"))
ggplot(cars, aes(x=transmission, y=mpg, fill=transmission)) +
  geom_boxplot() +
  xlab("Transmission type") +
  ylab("Miles per gallon")


str(cars$gear)


pairs(cars, panel=function(x,y) {
  points(x, y)
  abline(lm(y ~ x), col="red")
})

