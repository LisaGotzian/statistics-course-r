#------------------ Simple tests in R ------------------
# 
# Goal: show t-tests and other simple tests
#
# Lisa Gotzian, April 24, 2019

#shapiro-wilk
sample1 <- rnorm(70, mean = 0, sd = 1)
shapiro.test(sample1) # check the slides: what does this test?


# F-Test
sample1 <- rnorm(70, mean = 0, sd = 1)
sample2 <- rnorm(80, mean = 1, sd = 1)
var.test(sample1, sample2) # what does this test?

# Chi-Square
coffeeEarly <- as.table(rbind(c(40, 60), c(30, 20)))
dimnames(coffeeEarly) <- list(coffee = c("coffee", "non-coffee"),
                    time = c("early","late"))
chisq.test(coffeeEarly)
(Xsq <- chisq.test(M))  # Prints test summary
Xsq$observed   # observed counts (same as M)
Xsq$expected   # expected counts under the null
Xsq$residuals  # Pearson residuals
Xsq$stdres     # standardized residuals

# T tests
sample1 <- c(0.3,
             5.0,
             6.8,
             7.0,
             -0.1,
             -0.5,
             0.5,
             0.0,
             0.0,
             -2.0)

sample2 <- c(-3.0,
             -2.5,
             0.0,
             5.5,
             -0.1,
             -2.5,
             -3.0,
             -7.0,
             -4.5,
             0.0)
t.test(sample1, sample2) # What's the result?

arrival <- cbind(sample1, sample2)
library(reshape2)
arrival <- melt(arrival)
boxplot(value~ Var2, data = arrival)

data(sleep)
View(sleep)
boxplot(extra ~ group, data = sleep, main = "Effect of sleep-fostering drugs")
#abline(h = tapply(sleep$extra, sleep$group, mean))

t.test(extra ~ group, data = sleep, paired = TRUE)

plot(extra ~ group, data = sleep)
tapply(sleep$extra, sleep$group, mean) #mean by group
tapply(sleep$extra, sleep$group, hist)

# wilcoxon test
sample1 <- c(1.3,
             1.7,
             3.7,
             2.7,
             3.7,
             3.7,
             2.3,
             2.0,
             1.3,
             1.7)
sample2 <- c(2.3,
             2.7,
             2.0,
             2.0,
             1.7,
             1.3,
             3.0,
             3.0,
             1.3,
             3.7)
wilcox.test(sample1, sample2)
