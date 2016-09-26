install.packages('dplyr')
library(dplyr)

year_country_gdp <- select(gapminder,year,country,gdpPercap)
head (year_country_gdp)

El verdadero poder aparece usando los pipes

year_country_gdp <- gapminder %>% select(year,country,gdpPercap)
¿Cómo funcionan los pipes?

Usando filter()
Podemos filtrar usando filter()

year_country_gdp_euro <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)
 
