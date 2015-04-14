## To Learn gear shift or not. 

In the 1974 Motor Trend US magazine came out with Data which comprises fuel Consumptions and 10 other aspects of automobile performance. 

**Question**

Does MPG depend on transmission type (automatic vs. manual)?, If so, which is better for MPG? Quantify the MPG difference between automatic and manual transmissions.  

**Findings**   

Mileage (mpg), when modeled with just one predictor `am`, we get manual transmission to yield an average of `7.245`mpg higher than automatic transmission. Here, only  **33.85%** of variance could be explained.


Multiple regression on stepwise regressed variables defines **83.36**% of variability. `wt` and `qsec` have [confounded](http://en.wikipedia.org/wiki/Confounding) the relationship between `am` and `mpg`. Manual transmission in this model increases mileage by only `2.936 mpg`  



#### References / Credits

1. mtcars dataset <https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html>
2. Density Plot. <http://www.statmethods.net/graphs/density.html>   
3. Analysis on mtcars dataset to predict mpg <http://varianceexplained.org/RData/code/code_lesson3/>
4. BoxPlot using ggplot2 <http://www.statmethods.net/advgraphs/ggplot2.html>
5. More on factors <http://www.stat.berkeley.edu/~s133/factors.html>  
6. Confounding Variables <http://en.wikipedia.org/wiki/Confounding/>
7. two-sample t test <http://www.isixsigma.com/tools-templates/hypothesis-testing/making-sense-two-sample-t-test/>
8. Coursera regmods <https://github.com/sefakilic/coursera-regmods/>
