library(data.table)
library(dplyr)
library(ggplot2)
library(magrittr)
library(Seurat)

## load
setwd("C:/Users/Chenzhuoyang/Desktop/HKUST/data_visualization/")
dat <- read.csv("full_data.csv", header = T)
country <- read.csv("countries of the world.txt", header = T)
country$Country <- gsub(" $","",country$Country)
country$Country <- gsub("&","and",country$Country)
str(dat)
dim(dat)

## preprocess
dat[is.na(dat)] = 0
anyNA(dat)
today = Sys.Date()

##explore
up_to_date <- filter(dat, date == "2022-09-27")
rownames(up_to_date) <- up_to_date$location
head(sort(up_to_date$total_cases))
up_to_date$location[which(!up_to_date$location%in%country$Country)]

notCountry <- c("Africa","Asia","Europe","European Union","High income","International",
                "Low income","Lower middle income","North America","Oceania","South America",
                "Upper middle income","World")

write.csv(up_to_date %>% filter(!location%in%notCountry) %>% arrange(desc(total_cases)),
          row.names = F, file = "covid19_processed.csv")

#total_cases
ggplot(up_to_date %>% filter(!location%in%notCountry) %>% arrange(desc(total_cases)) %>% top_n(n=10, wt=total_cases) 
       %>% mutate(location = factor(location, levels = unique(location))), 
       aes(location, total_cases)) + 
  geom_bar(stat = "identity") + RotatedAxis()

ggplot(up_to_date %>% filter(!location%in%notCountry) %>% arrange(desc(total_cases)) %>% top_n(n=10, wt=total_cases) 
       %>% mutate(location = factor(location, levels = unique(location))), 
       aes(location, total_cases)) + 
  geom_bar(stat = "identity") + RotatedAxis()

ggplot(up_to_date %>% filter(!location%in%notCountry) 
       %>% mutate(fatality = total_deaths/(total_cases+1)) 
       %>% arrange(desc(fatality)) %>% top_n(n=10, wt=fatality) 
       %>% mutate(location = factor(location, levels = unique(location))), 
       aes(location, fatality)) + 
  geom_bar(stat = "identity") + RotatedAxis()

##continent only
dat <- read.csv("A2/covid19_processed.csv", header = T)
location <- read.csv("A3/locations.csv")
dat <- merge(dat, location, by = "location", sort = F)
write.csv(dat, file = "A3/covid_addContinent.csv", row.names = F)
