library(tidyverse)
bcData <- read_delim("SEERStat_Breast_2004_2009.txt",
           delim = ",", col_types = cols(
             `Agee (All, <50, 50+)` = col_character(),
             `Patient ID` = col_character(),
             `Record number` = col_character(),
             `Age at diagnosis` = col_double(),
             `Race recode (White, Black, Other)` = col_character(),
             Sex = col_character(),
             `Vital status recode (study cutoff used)` = col_character(),
             `Month of diagnosis recode` = col_character(),
             `Year of diagnosis` = col_double(),
             `Month of follow-up recode` = col_character(),
             `Year of follow-up recode` = col_double(),
             `End Calc Vital Status (Adjusted)` = col_character(),
             `Begin Calc Age (Adjusted)` = col_double(),
             `Number of Intervals (Calculated)` = col_double()
             ))
head(bcData)
summary(bcData$`Age at diagnosis`)
names(bcData)[1] <- "Age"
names(bcData)[2] <- "Patient_ID"
names(bcData)[3] <- "Record_number"
names(bcData)[4] <- "Age_at_diagnosis"
names(bcData)[5] <- "Race"
names(bcData)[6] <- "Sex"
names(bcData)[7] <- "Vital_status"
names(bcData)[8] <- "Month_of_diagnosis"
names(bcData)[9] <- "Year_of_diagnosis"
names(bcData)[10] <- "Month_of_followup"
names(bcData)[11] <- "Year_of_followup"
names(bcData)[12] <- "End_Calc_Vital_Status"
names(bcData)[13] <- "Begin_Calc_Age"
names(bcData)[14] <- "Number_of_Intervals"
head(bcData)

#total cases of breast cancer diagnosis in each year from 2004 to 2009
case_per_year <- bcData %>%
  group_by(Year_of_diagnosis) %>%
  summarize(totalcases = n())
view(case_per_year)
ggplot(case_per_year, aes(Year_of_diagnosis, totalcases))+
  geom_line(color = "green")+
  geom_point(color = "dark green")+
  labs(title = paste("Cases of Breast Cancer in each year 2004-2009"),
       caption = "Data from seer.cancer.gov",
       x = "Year of Diagnosis",
       y = "Cases")

#Number of breast cancer diagnosis cases in different ages
age_case <- bcData %>%
  group_by(Age_at_diagnosis) %>%
  summarize(cases = n())
view(age_case)

ggplot(age_case, aes(Age_at_diagnosis, cases))+
  geom_line(color = "orange")+
  geom_point (color = "red")+
  labs(title = paste("Cases of Breast Cancer Diagnosed in Different Ages"),
       caption = "Data from seer.cancer.gov",
       x = "Age at diagnosis", y = "Cases")

#diagnosis of breast cancer in different races from 2004 to 2009.

race_case <- bcData %>%
  group_by(Year_of_diagnosis, Race) %>%
  summarize(cases = n())
view(race_case)
  


ggplot(data = race_case, aes(x = Year_of_diagnosis, 
                             y = cases, group = Race)) +
  geom_point(aes(color = Race))+
  geom_line(aes(linetype = Race, color = Race))+ 
  theme(legend.position = "bottom")+
  labs(title = "Breast Cancer diagnosis in different races",
       x = "Year of Diagnosis", y = "Cases")
  

  
