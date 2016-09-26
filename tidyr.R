library("tidyr")
library("dplyr")


str(gapminder)

gap_wide <- read.csv("data/gapminder_wide.csv", stringsAsFactors = FALSE)

str(gap_wide)

gap_long <- gap_wide %>%
  gather(obstype_year,obs_values, starts_with('pop'),
         starts_with('lifeExp'), starts_with('gdpPercap'))

str(gap_long)
head(gap_long)
tail(gap_long)

gap_long <- gap_wide %>% gather(obstype_year,obs_values,-continent,-country)
str(gap_long)


gap_long <- gap_long %>% 
  separate(obstype_year,
           into = c('obs_type','year'), sep = "_")
gap_long$year <- as.integer(gap_long$year)


head(gap_long)




Usando gap_long, calcula la expectativa de vida, población, 
gdpPercap para cada contintente. Pista: usa las funciones group_by() y summarize() aprendidas en la lección de dplyr.


ej_2 <-group_by(gap_long2, continent)

summarise(ej_2, mean(lifeExp), mean(pop))


gap_by_continent <- gap_long %>% 
  group_by(continent,obs_type) %>% 
  summarise(media = mean(obs_values))

gap_by_continent


gap_normal <- gap_long %>% spread(obs_type, obs_values)

dim(gap_normal)
dim(gapminder)
dim(gap_long)

head(gap_normal)
head(gap_long)

names(gap_normal)
names(gapminder)


gap_normal <- gap_normal[,names(gapminder)]
all.equal(gap_normal,gapminder)


gap_normal <- gap_normal %>% arrange(country,continent,year)
all.equal(gap_normal,gapminder)


gap_temp <- gap_long %>% 
  unite(var_ID, continent, country, sep = "_")

gap_temp <- gap_long %>%
  unite(ID_var,continent,country,sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_")

gap_wide_new <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_") %>%
  spread(var_names, obs_values)

str(gap_wide_new)


Lleva esto un paso más lejos y crea gap_ridiculamente_ancho 
extendiendo paises, año y las tres medidas. 
Pista la nueva data.frame debería tener solo 5 filas


gap_ancho <- gap_long %>%
  unite(ID_var, country, year, obs_type, sep = "_") %>%
  spread( ID_var, obs_values)
  
head (gap_ancho)

  dim(gap_ancho)