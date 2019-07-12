#------------------ Basics in R ----------------------
# 
# Goal: understanding how R works.
#
# Lisa Gotzian, April 11, 2019

x <- 10 # if I type here, I save which steps I took
y <- 11
x + y # the result

z <- x + y # I can also assign it to a new variable
z/2
z # z still looks the same!

z <- z/2 # z doesn't look the same!

# Create a variable called "first" and assign it 20. Subtract it
# from "second" (which can be any number you pick).

first <- 20

#--------------- Packages --------------------
# Packages are the power R works with.

install.packages("beepr") # installs the package, only once
library(beepr) # every time you start R, you have to load the package

# search for "beepr" in the help
beep(3)

#------------- Arguments and functions -----------------
# Everything that ends with "()" is a function.
beep(3) # beep() is a function.

x <- 10
str(x) # str() is a function.

# Everything that's inside the brackets is an argument.
# They are listed in the help. Go to the help for the beep function!

beep(2) # What happens?
beep(sound = 2) # is the same. When you don't provide the name, it
# assumes it based on the position, so...
beep(sound = 2, expr = NULL) # is the same as 
beep(expr = NULL, sound = 2) # as this:
beep(2, NULL)

# Why the second part?
# As it is provided as a default, we ignore it if we don't want to change it.
# What could the expr be?

print("Yay!") #print is a function

beep(sound = 2, expr = print("Yay!")) # we can nest a function 

#------------- Inspecting your data ------------
library(datasets) # I need this library to call the following function:
data(airquality) # I now have an "airquality" object

# Now here are one of the two most basic things you can do with it:
str(airquality)
summary(airquality)

# Call the following datasets: Orange, Titanic and rock
# and inspect them.
# Click on them (RStudio ftw! ;)).
