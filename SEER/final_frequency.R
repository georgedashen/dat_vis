library(dpylr)
library(data.table)
df <- fread("./cancer_freq.csv")
View(df)
colnames(df) #show columns
unique(df$`Site - malignant (least detail)`) #there is a "not applicable"
unique(df$`Rural-Urban Continuum Code`) #discibe where the patients from
#for patient personal info. protection, records will be reported two years later
#so latest diagnosis record is 2019, reported in 2022
unique(df$`Age recode with <1 year olds`) #there is a "2000-2019" total
unique(df$`Race and origin recode (NHW, NHB, NHAIAN, NHAPI, Hispanic) - no total`)


