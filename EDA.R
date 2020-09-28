# Assignment: EDA, Functions, visuals & mapping
#Kshitij Sankesara
 
## Load the libraries, maps ggplot2, ggthemes
library(maps)
library(ggplot2)
library(ggthemes)


## Exercises
# 1. Read in diamonds.csv data and call it 'df'
df <-read.csv('diamonds.csv')

# 2. Examine the first 10 rows of data
head(df, 10)

# 3. What is the first value for the 'color' column when looking at head()? 
# Answer: E

# 4. Create a new data frame called 'diamonds' by sorting the 'df' object by price and decreasing is FALSE
diamonds <- df[order(df$price, decreasing=F),]

# 5. Examine the last 6 rows by calling 'tail()' on the 'diamonds' data frame.  What is the most expensive diamond in the set?
tail(diamonds)
# Answer: 27750  2.29   Premium     I     VS2  60.8    60 18823 8.50 8.47 5.16

# 6. Copy and paste the results of the 'summary()' stats for the 'caret' attribute below.  You can use either $ or the index to get the vector
library(Hmisc)
summary(diamonds$caret)

# Introducing additional functions to try out, don't worry these are straight forward:

# 7. What is the maximum value for the "depth" attribute?
max(diamonds$depth)
# Answer: 79

# 8. What is the minimum value for the "table" attribute?
min(diamonds$table)
# Answer: 43

# 9. What is the range of values for the "price" column?
range(diamonds$price)
# Answer:326 , 18823 = 18497

# 10. Find the 347th diamond in the data set using row indexing.  Copy paste the single row below.
diamonds[347,]

# 11. Create a barplot of the diamonds' cut and name it barplot.jpg
diamonds_cut <- as.matrix(table(diamonds$cut))
barplot(diamonds_cut[1:5], main='barplot.jpg',las = 2)

# 12. Create a ggplot scatterplot of points with the following aesthetics:
# color = clarity
# x axis = carat
# y axis = price
# point size size = 0.25
# theme = theme_economist_white()
# legend = none
ggplot(diamonds, aes(x = carat, y = price, colour = clarity)) + geom_point(size = 0.25) + 
    theme_economist_white() + theme(legend.position = 'none')


# 13. Examine the price distribution by creating a ggplot geom_histogram() instead of a scatter plot layer.  Use the code scaffold below with the following parameters:
# data = diamonds
# type = geom_histogram
# x = price (we are only examining a single attribute here)
# bin width = 100
ggplot(diamonds) + geom_histogram(aes(x=price), binwidth=100)


#14. What is the class() of the carat vector?  HINT: apply class() as a function to the carat column using $ or index number
class(diamonds$carat)

#15. What is the class of the color vector?
class(diamonds$color)

#16. Read in the WesternCellTowers.csv cell towers as westTowers
westTowers <- read.csv('WesternCellTowers.csv')

#17. Using map() create a state map of 'oregon', 'utah', 'nevada', 'california' 
#& add points() with westtowers$lon,westtowers$lat, col='blue'
map('state', region = c('oregon', 'utah', 'nevada', 'california'))
points(westTowers$lon, westTowers$lat, col = 'blue')

#18. Load the county map data called counties (HINT: with map_data)
counties <- map_data('county')

#19. Load the state data called state 
allStates <- map_data('state')

#20. Subset counties and allStates into the objects below; add the last states, california & nevada to the search index
westernCounties <- counties[counties$region %in% c("oregon","utah", "california", "nevada"),]
westernStates   <- allStates[allStates$region %in% c("oregon","utah", "california", "nevada"),]

#21. Create a ggplot map of the cell phone towers in the 4 western states. Refer to the lesson's example code.
library(mapproj)
cell_towers <- subset(westTowers,westTowers$state%in% c('CA','NV','OR','UT'))
ggplot() + geom_map(data= westernStates, map = westernStates,aes(x = long, y = lat, map_id = region, group = group),
                    fill = 'white', color = 'black', size = 0.25) + 
                    coord_map('albers', lat0 = 39, lat1 = 45) +  theme_map()+ 
                    geom_point(data=cell_towers, aes(x=lon, y=lat, group=1), color='red', alpha=0.15)

# End

