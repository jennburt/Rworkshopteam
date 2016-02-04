#SOFTWARE CARPENTRY WORKSHOP NOTES
# FEB. 2-3 2016
#Yes indeed this sounds cool
##############################################################################-
# Day 1:  ####
# START WITH SOME BASIC FUNCTIONALITIES IN R  ###############-
##############################################################################-
setwd("~/Documents/workshopR/my-project")

# R does math
# how do you take the log of a number
?log  #let's find out
log(5)  #the default is to take the natural log (ie. ln)
log10(5)  #have to specify if you want base 10 log
!=   #not equal to
>=   #greater than or equal to
<=   #less than or equal to
1 <= 2
2 <= 2
3 <= 2

#create an object, making variables
x <- 100
y <- 2*x

#challenge #1
#what will the following code return?
x <- 1
x <- x+1
#ans = 2
x  #yup

# memory/work-space managment ####
ls()
rm(x)
rm(c(x,y))
?rm
rm(list=ls(x,y))

# read in data
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",")
cats

#manipulate data
cats$weight[1]
cats[,1]

#challenge problem
#what will the following print out and why?
cats$weight[1] + cats$coat[2]
# error - b/c you want to add a number to a factor.

typeof(cats$weight[1])
typeof(cats$coat[2])


# 5 main types of data in R ####
typeof(3.14)  #decimals are "double"
typeof(1)      #this is also called "double" (basically a number...)
typeof(FALSE)  # this is "logical"  (these are true/false things)
typeof('SWC')  # this is a "character"
typeof(1+1i)   # this is "complex"
typeof(1L)   # this is an "integer" (for some reason, if you add an 'L' to the end, nobody knows why really)

#adding some data
cats
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",")
cats$weight[1] + cats$weight[2]
cats

#introducing vectors ####
x <- vector(length = 3)
x
x <- vector('character', length=3)
x
x <- c(2,3,6)
#note, if you create a vector with one character.....it will default them all to character
x <- c(2,3,"6")
x    #now you see they are all characters - this is called "type coersion"
x <- c("a", TRUE)
x
x <- c(0, TRUE)   # here you will see that it turns the "TRUE" to a "1"
x
# all of this is called 'type coersion', and the order of coersion goes like this:
# logical -> integer -> double -> complex -> character

x <- c("0", "2", "4")
x
y <- as.numeric(x)    #this shifts the data now (from character) to numeric
y <- as.logical(x)    #it doesn't like this, b/c logical is too far 'up the coersion chain'
y
#but it will work if you use it in a two step transformation
y <- as.numeric(x)
z <- as.logical(y)
z

# a few other ways of making simple vectors
#use a sequence
x <- seq(10)
x
head(x, n=2)
tail(x, n=4)
length(x)
# another way to make a sequence
x <- 1:4  #make a vector with numbers 1-4
x
names(x) <- c("a", "b", "c", "d") #now give names to your vector (ie. add a header column)
x

# challenge problem
# make a vector with the numbers 11 to 20
j <- 11:20
j
#then use the functions we have learned so far to extract the third through 5th element in the vector
j
k <- j[3:5]
k
# then name the elements in that vector '5', 'W', and 'C'
names(k) <- c("S", "W", "C")
k

# investigating structure of your data ####
x <- 1:4
str(x)
cats
str(cats$weight)
str(cats$likes_string)  #this is strange....it's telling you it's a factor with 3 levels....
# Ans: there is white space after one of the FALSE values
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE)  #so remove this during import
cats
str(cats$likes_string)  #now it's fixed
summary(cats)  #another way to summarize the data


#introducting factors
str(cats$coat)   #look at this and notice that in fact, the 'coat' column is being recognized as a "factor"

coats <- c("tabby", "tortoise", "tortoise", "black", "tabby")
str(coats)
CATegories <- as.factor(coats)
str(CATegories)

typeof(coats[1]) #look at the type of data our first value in the coats vector is... ans=character (as expected)
typeof(CATegories[1]) #now note this is calling the first value an "integer"
# this is because R considers "factors" to just be like coded integers - "1", "2", and "3" factors

#Challenge problem - tweek import data ####
#try using the help function for read.table to figure out how to keep text columns as character vectors when we read our data.
# then write a line or 2 to demonstrate that the coats column is infact a character vector
?read.table

#here is a try....
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE, colClasses = "character")  
str(cats)  #now ALL data is characters, so no good

#this works!
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE, stringsAsFactors = F) 
#this is another way to do it

#this also works
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE, as.is = TRUE)  
str(cats)  


#learn about lists ####
# lists are similar to vectors....but they don't care what you put in them - they don't coerse data to all be the same
# lists are also similar to dataframes....
# essentially, dataframes are a "list of vectors" - each column is a vector...
x <- list(1, "a", TRUE, 1+4i)
x
x[2]
x <- list(title = "Research Bazaar", numbers = 1:10, bill = TRUE)
x
x$title
x$bill
#note, you can call list items just like you specify things in a vector or dataframe - using "$"


# the maxtrix ####
x <- matrix(0, ncol=6, nrow=3)
x
x[1,1] = 1  #puts a number one in the position 1,1 in the matrix
x


#challenge problem - create list of vectors ####
# create a list of length 2 containing a character vector
# for each of the sections in this part of the workshop:
# - names of data types
# - names of data structures
# populate each character vector with the names of the data
# types and data structures we've seen so far

#one way to do it: create the vectors, then stick them together in a list
vector1 <- c("logical", "integer", "double", "complex", "character")
vector2 <- c("double", "vector", "list", "factor", "matrix")
JB <- list(datatype = vector1, datastructure = vector2)
JB
JB2 <- data.frame(datatype = vector1, datastructure = vector2)
JB2
JB3 <- as.data.frame(JB)
JB

#another way to do it: create the 'shell' then fill it up
pascale <- list()
pascale$data_type <- c("logical", "integer", "double", "complex", "character")
pascale$data_structure <- c("double", "vector", "list", "factor", "matrix")
pascale


cats
#add columns + rows to our dataframe ####
# add column
cats <- cbind(cats, c(2,6,12,4,5))
#gives error b/c trying to add a column with 5 rows to a dataframe with 4 rows
# needs to be the same
cats <- cbind(cats, c(2,6,12,1))
#works, but the name sucks. So change it.
names(cats)[4] <- 'age'
cats
#but now the dataframe is really ugly...because it keeps adding columns
#so keep only the columns I'm interested in
cats <- cats[,1:4]
cats

#add a new row onto our dataframe
cats <- rbind(cats, list('tortoise', 4.0, TRUE, 9))
cats

# TO REMEMBER!!!!****
# for columns:   c(1, 2, 3)
# for rows:   list(1, 2, 3)

#removing NA's
na.omit(cats)


#lets work with some new data
gappy <- read.table(file="data/gapminder-FiveYearData.csv", header=TRUE, sep=",", strip.white=TRUE) 
str(gappy)
typeof(gappy) #I would think it should be "dataframe" ....but comes out as a 'list' - which is essentially what a dataframe is...

#start plotting stuff with ggplot ####
library(ggplot2)

#plot gdp as a function of life expectancy
ggplot(data = gappy, aes(x = lifeExp, y = gdpPercap)) + geom_point() +theme_bw()

#plot gdp as a function of year
ggplot(data = gappy, aes(x = year, y = gdpPercap)) + geom_point() +theme_bw()

#now add colour to the POINTS and a layer of lines (which will also have colour)
ggplot(data = gappy, aes(x = year, y = gdpPercap, by=country, colour=continent)) +theme_bw() +
  geom_point() +
  geom_line()

#now add colour and a layer of lines
ggplot(data = gappy, aes(x = year, y = gdpPercap, by=country)) +theme_bw() +
  geom_line(aes(colour=continent)) +
  geom_point()
  

#now look at the data JUST for the continent of 'Africa' AND less than 15000 GDP
ggplot(data = subset(gappy, continent=="Africa" & gdpPercap<15000), aes(x = year, y = gdpPercap)) +theme_bw() +
  geom_point() +
  geom_line(aes(colour=continent, by=country))


##############################################################################-
#Day 2: ####
##############################################################################-

#let's start fresh
rm(list=ls())

#re-load data
gappy <- read.table(file="data/gapminder-FiveYearData.csv", header=TRUE, sep=",", strip.white=TRUE) 
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE) 

#check str of data
str(gappy)
str(cats)
head(gappy)

#subsetting data ####

# how many ways can one extract the weight column data from cats?
weight <- cats[,2]  #this just makes a list of numbers
weight2 <- cats[1:4,2] #this just makes a list of numbers
weight2b <- cats[1:nrow(cats),2] #same as above, but a way of saying "take all my rows, however long it is"
weight3 <- cats$weight  #this just makes a list of numbers
weight4 <- cats[2]    #this makes a new dataframe - it says "select the second 'item/vector' in my dataframe list of vectors"
#can also do it as a vector of logicals
weight5 <- cats[,c(FALSE,TRUE,FALSE)]

#if you want to select 2 columns
cats[,c("weight", "coat")]

#can ask R to give you logical info back based on conditions
cats$weight > 3

#challenge - extract data
#get the rows from the dataframe that have a weight value > 3
ans <- cats[cats$weight>3, ]
ans2 <- subset(cats, weight>3)

#challenge - subsetting
# subset the gappy dataframe to only include data from canada.
# store the dataframe as a new dataframe called gappyCanada
# bonus: plot the population by year in canada

gappyCanada <- gappy[gappy$country=="Canada",]
gappyCanada <- subset(gappy, country=="Canada")
ggplot(data = gappyCanada, aes(x = year, y = pop)) +theme_bw() +
  geom_point() +
  geom_line() +
  ylab("Human population") + xlab("Year")

gappyGermany <- gappy[gappy$country=="Germany",]

#plot Germany
ggplot(data = gappyGermany, aes(x = year, y = pop)) +theme_bw() +
  geom_point() + geom_line() +
  ylab("Human population") + xlab("Year")

#plot both!
ggplot(data = gappyCanada, aes(x = year, y = pop)) +theme_bw() +
  geom_point() + geom_line() +
  geom_point(data = gappyGermany, aes(x = year, y = pop)) + 
  geom_line(data = gappyGermany, aes(x = year, y = pop))+
  ylab("Human population") + xlab("Year")

#play with faceting
ggplot(data = subset(gappy, lifeExp>80), aes(x = year, y = pop, colour=country)) +theme_bw() +
  geom_point() +
  geom_line() +
  facet_wrap(~country, ncol=3)   




# intro fuctions ####

#this code would make salsa if I had binary vegetables
# has 3 main steps: washing, cutting, 'bowl'ing

makeSalsa <- function(vegetable){
  #instructions
  #1. wash vegetables
  #2. cut vegetables
  #3. put in bowl
  return(salsa)
}

 
gappyGermany <- gappy[gappy$country=="Germany",]
ggplot(data = gappyGermany, aes(x = year, y = pop)) +theme_bw() +
  geom_point() + geom_line()

# parameters are myData and myCountry
# myData is a dataframe with a "country" column and a "year" column and a "pop" column
# myCountry is a string (i.e. word) that is found in data's "country" column
plotPopByCountry <- function(myData, myCountry){
  dataCountry <- myData[myData$country == myCountry,]
  plot <- ggplot(data = dataCountry, aes(x= year, y= pop))+
    geom_line()
  return(plot)  
}

#store your function to file ####
# first copy and paste your function into a FRESH R.script and save it somewhere (ideally in a "functions" folder within your project directory)
# then when you want to "call AND run" your funciton, use the code below
# THIS 'CALLS' AND 'RUNS' ALL THE CODE in that source file. So ONLY SAVE A FUNCTION, not other junk code.
source(file="functions/plotPopByCountry.R")


#now run your function
plotPopByCountry(myData = gappy, myCountry = "Canada")
plotPopByCountry(myData = gappy, myCountry = "China")

# Challenge - function
# write a function that takes the cats dataframe and returns the sum of the weights column

#one answer
sumweight <- function(mydata){
  weights <- mydata$weight
  sumweight <- sum(weights)
  return(sumweight)
}
sumweight(mydata=cats)

#another answer
sumweight <- function(mydata){
  sumweight <- sum(mydata$weight)
  return(sumweight)
}
sumweight(mydata=cats)



sumweight <- function(mydata){
  weights <- mydata$weight
  sumweight <- sum(weights)
  return(sumweight)
}

sumweight(mydata=cats)


# 
rm(list=ls())
#re-load data
gappy <- read.table(file="data/gapminder-FiveYearData.csv", header=TRUE, sep=",", strip.white=TRUE) 
cats <- read.table(file="data/cats.txt", header=TRUE, sep=",", strip.white=TRUE) 

source(file="functions/plotPopByCountry.R")

#now run your function
library(ggplot2)
plotPopByCountry(myData = gappy, myCountry = "Canada")
plotPopByCountry(myData = gappy, myCountry = "China")
