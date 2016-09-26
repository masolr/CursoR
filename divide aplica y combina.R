
gapminder <- read.csv(file="data/gapminder-FiveYearData.csv")


library(ggplot2)
library(plyr)

install.packages("ggplot2")
install.packages("plyr")


calcPBI <- function(dat, year=NULL, country=NULL) {
  if (!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
  gdp <- dat$pop * dat$gdpPercap
  new <- cbind(dat, gdp = gdp)
  return(new)
}

head (gapminder)
head(calcPBI(gapminder, year = 2007))


conPBI <- calcPBI(gapminder)




ddply(
  .data = calcPBI(gapminder),
  .variables = "continent",
  .fun = function(x) mean(x$gdp)
)

#me hace una ~lista#

promedios_pbi <- dlply(
  .data = calcPBI(gapminder, year = 2007),
  .variables = "continent",
  .fun = function(x) mean(x$gdp)
)

promedios_pbi


promedios_pbi <- daply(
  .data = calcPBI(gapminder, year = 2007),
  .variables = "continent",
  .fun = function(x) mean(x$gdp)
)

promedios_pbi


#me hace una matriz porque uso daply las dos entradas seran continente y años#
promedios_pbi <- daply(
  .data = calcPBI(gapminder),
  .variables = c("continent","year"),
  .fun = function(x) mean(x$gdp)
)

promedios_pbi



d_ply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) {
    meanGDPperCap <- mean(x$gdpPercap)
    print(paste(
      "The mean GDP per capita for", unique(x$continent),
      "is", format(meanGDPperCap, big.mark = ",")
    ))
  }
)


concoma <- function(x) {
  format (x, decimal.mark = ",")
  
}

concoma (1.003)
concoma (3.003)

head(gapminder)

media <-ddply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) mean(x$lifeExp)
)
media



media [which.max(media$V1),]

maxymin <- media [c(which.max(media$V1),which.min(media$V1)),]
maxymin


max <-ddply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) max(x$lifeExp) 
)

min <-ddply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) min(x$lifeExp)
)

min

laTabla = data.frame (cbind(media, max, min))
laTabla


laTabla2 = data.frame (rbind(media, max, min))
laTabla2




media2 <-daply(
  .data = gapminder,
  .variables = c("continent", "year"),
  .fun = function(x) mean(x$lifeExp)
)
media2



media3 <-ddply(
  .data = (gapminder[gapminder$year == 2007,]),
  .variables = c("continent","year"),
  .fun = function(x) mean(x$lifeExp)
)
media3

media3 [which.max(media3$V1),]
media3 [which.min(media3$V1),]


media4 <-ddply(
  .data = (gapminder[gapminder$year == 1952,]),
  .variables = c("continent","year"),
  .fun = function(x) mean(x$lifeExp)
)
media4


media5 <-ddply(
  .data = gapminder[gapminder$year %in% c (1952,2007), ],
  .variables = c("continent","year"),
  .fun = function(x) mean(x$lifeExp)
)
media3
media4

media1952y2007 <- cbind(media3, anio1952 = media4$V1)
names (media1952y2007) [3] <- "anio2007"
media1952y2007

media1952y2007$diferencia <- with (media1952y2007, anio2007 - anio1952)

media1952y2007

media1952y2007 <- media1952y2007 [,-2]
media1952y2007 <- media1952y2007 [,-4]
media1952y2007

#ejercicio avanzado#
ejemplo <-ddply(
  .data = media1952y2007,
  .variables = "continent",
  .fun = function(x) x[,2]-x[,3]
)

ddply(gapminder, .(continent), summarise,
      media_lifeExp = mean(lifeExp),
      sd_lifeExp = sd(lifeExp))
