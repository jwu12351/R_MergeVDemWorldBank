install.packages('WDI') 
library(WDI) 
library(remotes)
install_github('vincentarelbundock/WDI')
WDIsearch('gdp')
install.packages(haven)
library(haven)
install.packages("foreign")
library(foreign)


### https://joenoonan.se/post/country-code-tutorial/
### Tutorial shows how to merge world bank dataset with vdem 

#load world bank dataset 
########################################################################################################################
worldbank_var2022 <- WDI(indicator = c("SP.POP.TOTL", "NY.GDP.PCAP", "NY.GDP.MKTP.CD", "SL.TLF.CACT.FM.ZS", "SG.GEN.PARL.ZS"),
                         start = 2000, end = 2022)
View(worldbank_var2022)


#load V-dem dataset 
########################################################################################################################
library(dplyr)
### Loading V-Dem .RData 
library(tidyverse)
load(url("https://github.com/vdeminstitute/vdemdata/raw/master/data/vdem.RData")) #load V-dem Dataset

# Assuming you have the vdem data frame; in the （）identify the variabels that you need from Vdem
vdem_2022 <- vdem %>%
  filter(year >= 2000, year <= 2022) %>%
  select(country_name, year, country_id, COWcode, v2x_polyarchy, v2x_gender, v2x_gencs, v2x_genpp)

View(vdem_2022)


#load package countrycode to find the common standardized variables to merge those two datasets
########################################################################################################################
install.packages('countrycode')
library(countrycode)

### Adding the iso3c codes to the V-Dem Dataset
vdem_2022_iso3c <- vdem_2022 %>% 
  mutate(iso3c = countrycode(country_id, "vdem", "wb"))

### Checking missing country codes
filter(vdem_2022_iso3c, is.na(iso3c))

### Creating custom match criteria
malta_match <- c("178" = "MLT")

### Creating new dataset
### Adding custom match argument and filtering out countries

vdem_2022_iso3c <- vdem_2022 %>% 
  mutate(iso3c = countrycode(country_id, "vdem", "wb", 
                             custom_match = malta_match)) %>% 
  filter(!country_name %in% c("Palestine/West Bank", "Palestine/Gaza", "Somaliland", "Zanzibar", "Republic of Vietnam", "German Democratic Republic"))

### Check to see if there are cases missing iso3c
filter(vdem_2022_iso3c, is.na(iso3c))

## Check Malta and Kosovo
filter(vdem_2022_iso3c, country_name %in% c("Malta", "Kosovo"))


#Now merge two datasets
########################################################################################################################
library(dplyr)
merged_data <- left_join(vdem_2022_iso3c, worldbank_var2022, by = c("iso3c", "year"))

# Check for duplicates in vdem_2020_iso3c data frame
# duplicate_rows_vdem <- vdem_2020_iso3c[duplicated(vdem_2020_iso3c[, c("iso3c", "year")]), ]

# Check for duplicates in worldbank_var data frame
# duplicate_rows_worldbank <- worldbank_var[duplicated(worldbank_var[, c("iso3c", "year")]), ]

#remove a data frame

