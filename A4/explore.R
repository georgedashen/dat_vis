library(ggplot2)
library(magrittr)
library(dplyr)
library(Seurat)
library(tidyr)

setwd("C:/Users/Chenzhuoyang/Desktop/HKUST/data_visualization/A4")

#### explore =================
list.files("s_weather/")
s1 <- read.csv("s_weather/s_weather_1.csv")
s2 <- read.csv("s_weather/s_weather_2.csv")
s3 <- read.csv("s_weather/s_weather_3.csv")
s4 <- read.csv("s_weather/s_weather_4.csv")
s23 <- read.csv("s_weather/s_weather_23.csv")
## sample from 152 locations, s1 from 2021-07-22 12:00
## every 4 hrs for each file, location and order remain the same
## end on 2021-07-26 04:00

str(s1)

#### combined ================
dat <- s1
for(i in 2:23){
  new <- read.csv(paste0("s_weather/s_weather_",i,".csv"))
  dat <- rbind(dat,new)
}

write.csv(dat, file = "weather_combined.csv")

combined <- read.csv("weather_combined.csv")

DateTime <- unique(combined[,c(5,6)])
write.csv(DateTime, file = "DateTime.csv", row.names = F)
