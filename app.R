library(tidyverse)
library(shiny)
library(EnvStats)

# importing the NIBRS data (downloaded from the FBI website)
NIBRS_ACTIVITY_TYPE <- read_csv("NIBRS_ACTIVITY_TYPE.csv",col_types = cols(ACTIVITY_TYPE_CODE = col_factor(levels = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11"))))

NIBRS_AGE <- read_csv("NIBRS_AGE.csv")

NIBRS_ARREST_TYPE <- read_csv("NIBRS_ARREST_TYPE.csv")

NIBRS_ARRESTEE <- read_csv("NIBRS_ARRESTEE.csv", col_types = cols(MULTIPLE_INDICATOR = col_factor(levels = c("N", "C", "M")), SEX_CODE = col_factor(levels = c("M","F"))))

NIBRS_ARRESTEE_WEAPON <- read_csv("NIBRS_ARRESTEE_WEAPON.csv")

NIBRS_ASSIGNMENT_TYPE <- read_csv("NIBRS_ASSIGNMENT_TYPE.csv", col_types = cols(ASSIGNMENT_TYPE_CODE = col_factor(levels = c("F", "G", "H", "I", "J", "K", "L"))))

NIBRS_BIAS_LIST <- read_csv("NIBRS_BIAS_LIST.csv")

NIBRS_BIAS_MOTIVATION <- read_csv("NIBRS_BIAS_MOTIVATION.csv")

NIBRS_CIRCUMSTANCES <- read_csv("NIBRS_CIRCUMSTANCES.csv", col_types = cols(CIRCUMSTANCES_TYPE = col_factor(levels = c("A", "J", "N"))))

NIBRS_CLEARED_EXCEPT <- read_csv("NIBRS_CLEARED_EXCEPT.csv", col_types = cols(CLEARED_EXCEPT_CODE = col_factor(levels = c("A", "B", "C", "D", "E", "N"))))

NIBRS_CRIMINAL_ACT <- read_csv("NIBRS_CRIMINAL_ACT.csv")

NIBRS_CRIMINAL_ACT_TYPE <- read_csv("NIBRS_CRIMINAL_ACT_TYPE.csv", 
                                    col_types = cols(CRIMINAL_ACT_CODE = col_factor(levels = c("B","C", "D", "E", "O", "P", "T", "U","N", "G", "J", "A", "F", "I", "S"))))

NIBRS_DRUG_MEASURE_TYPE <- read_csv("NIBRS_DRUG_MEASURE_TYPE.csv",col_types = cols(DRUG_MEASURE_CODE = col_factor(levels = c("GM", "KG", "OZ", "LB", "ML", "LT", "FO", "GL", "DU", "NP", "XX"))))

NIBRS_ETHNICITY <- read_csv("NIBRS_ETHNICITY.csv", col_types = cols(ETHNICITY_CODE = col_factor(levels = c("M", "H", "N", "U"))))

NIBRS_INJURY <- read_csv("NIBRS_INJURY.csv", col_types = cols(INJURY_CODE = col_factor(levels = c("B", "I", "L", "M", "N", "O", "T", "U"))))

NIBRS_JUSTIFIABLE_FORCE <- read_csv("NIBRS_JUSTIFIABLE_FORCE.csv", col_types = cols(JUSTIFIABLE_FORCE_CODE = col_factor(levels = c("A", "B", "C", "D", "E", "F", "G", "U"))))

NIBRS_LOCATION_TYPE <- read_csv("NIBRS_LOCATION_TYPE.csv", col_types = cols(LOCATION_CODE = col_factor(levels = c("01", "02", "03", "04", "05", "06", "07", "08", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "37", "38", "39", "40", "41", "42", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "09", "58", "00"))))

NIBRS_OFFENDER <- read_csv("NIBRS_OFFENDER.csv", col_types = cols(SEX_CODE = col_factor(levels = c("M", "F", "U"))))

NIBRS_OFFENSE <- read_csv("NIBRS_OFFENSE.csv", col_types = cols(ATTEMPT_COMPLETE_FLAG = col_factor(levels = c("C", "A"))))

NIBRS_OFFENSE_TYPE <- read_csv("NIBRS_OFFENSE_TYPE.csv")

NIBRS_PROP_DESC_TYPE <- read_csv("NIBRS_PROP_DESC_TYPE.csv")

NIBRS_PROP_LOSS_TYPE <- read_csv("NIBRS_PROP_LOSS_TYPE.csv")

NIBRS_PROPERTY <- read_csv("NIBRS_PROPERTY.csv")

NIBRS_PROPERTY_DESC <- read_csv("NIBRS_PROPERTY_DESC.csv")

NIBRS_RELATIONSHIP <- read_csv("NIBRS_RELATIONSHIP.csv", col_types = cols(RELATIONSHIP_CODE = col_factor(levels = c("AQ","BE", "BG", "CF", "CH", "CS", "EE", "ER", "FR", "GC", "GP", "HR", "IL", "NE", "OF", "OK", "PA", "RU", "SB","SC","SE","SP","SS","ST","VO","XS","XR"))))

NIBRS_SUSPECT_USING <- read_csv("NIBRS_SUSPECT_USING.csv")

NIBRS_VICTIM <- read_csv("NIBRS_VICTIM.csv")

NIBRS_VICTIM_CIRCUMSTANCES <- read_csv("NIBRS_VICTIM_CIRCUMSTANCES.csv")

NIBRS_VICTIM_INJURY <- read_csv("NIBRS_VICTIM_INJURY.csv")

NIBRS_VICTIM_OFFENDER_REL <- read_csv("NIBRS_VICTIM_OFFENDER_REL.csv")

NIBRS_VICTIM_INJURY <- read_csv("NIBRS_VICTIM_INJURY.csv")

NIBRS_VICTIM_TYPE <- read_csv("NIBRS_VICTIM_TYPE.csv", col_types = cols(VICTIM_TYPE_CODE = col_factor(levels = c("B", "F", "G", "I", "L", "O", "R", "S", "U"))))

NIBRS_WEAPON <- read_csv("NIBRS_WEAPON.csv")

REF_RACE <- read_csv("REF_RACE.csv")

REF_STATE <- read_csv("REF_STATE.csv")

#########
# data cleaning. Creating 2 datasets according to the main division in the dataset, that being between arrestees and offenders.

# arrestees

arrestees<-NIBRS_ARRESTEE %>% 
  select(ARRESTEE_ID, INCIDENT_ID, ARREST_TYPE_ID, OFFENSE_TYPE_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID)

arrestees<-full_join(arrestees,NIBRS_ARREST_TYPE,by="ARREST_TYPE_ID") %>%
  select(ARRESTEE_ID, INCIDENT_ID, ARREST_TYPE_NAME, OFFENSE_TYPE_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID)

# shorten name of arrestees dataset
arr<-arrestees

arr<-full_join(arr,NIBRS_OFFENSE_TYPE,by="OFFENSE_TYPE_ID") %>%
  select(ARRESTEE_ID, INCIDENT_ID, ARREST_TYPE_NAME, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID)

arr<-full_join(arr,REF_RACE,by="RACE_ID") %>%
  select(ARRESTEE_ID, INCIDENT_ID, ARREST_TYPE_NAME, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_ID)

arr<-full_join(arr,NIBRS_ETHNICITY,by="ETHNICITY_ID") %>%
  select(ARRESTEE_ID, ARREST_TYPE_NAME, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, AGE_NUM, SEX_CODE, RACE_CODE, ETHNICITY_CODE, ETHNICITY_NAME)

############

# offenders

off<-NIBRS_OFFENDER %>%
  select(OFFENDER_ID, INCIDENT_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID)

off<-full_join(off,NIBRS_OFFENSE,by="INCIDENT_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_TYPE_ID, LOCATION_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID)

bias<-full_join(NIBRS_BIAS_LIST,NIBRS_BIAS_MOTIVATION,by="BIAS_ID")

off<-full_join(off,bias,by="OFFENSE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_TYPE_ID, LOCATION_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_OFFENSE_TYPE,by="OFFENSE_TYPE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, LOCATION_ID, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_LOCATION_TYPE,by="LOCATION_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_ID, ETHNICITY_ID,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,REF_RACE,by="RACE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_ID,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_ETHNICITY,by="ETHNICITY_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_CRIMINAL_ACT,by="OFFENSE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_ID, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_CRIMINAL_ACT_TYPE,by="CRIMINAL_ACT_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC)

off<-full_join(off,NIBRS_PROPERTY,by="INCIDENT_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_ID, STOLEN_COUNT, RECOVERED_COUNT)

off<-full_join(off,NIBRS_PROP_LOSS_TYPE,by="PROP_LOSS_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT)

off<-full_join(off,NIBRS_PROPERTY_DESC, by="PROPERTY_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_ID, PROPERTY_VALUE)

off<-full_join(off,NIBRS_PROP_DESC_TYPE,by="PROP_DESC_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE)

NIBRS_VICTIM<-NIBRS_VICTIM %>%
  rename(VIC_AGE_NUM=AGE_NUM, VIC_SEX_CODE=SEX_CODE, VIC_RACE_ID=RACE_ID, VIC_ETHNICITY_ID=ETHNICITY_ID)

off<-full_join(off,NIBRS_VICTIM,by="INCIDENT_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, ASSIGNMENT_TYPE_ID, ACTIVITY_TYPE_ID, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_ACTIVITY_TYPE,by="ACTIVITY_TYPE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, ASSIGNMENT_TYPE_ID, ACTIVITY_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_ASSIGNMENT_TYPE,by="ASSIGNMENT_TYPE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off, NIBRS_VICTIM_CIRCUMSTANCES,by="VICTIM_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, CIRCUMSTANCES_ID, JUSTIFIABLE_FORCE_ID, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_CIRCUMSTANCES,by="CIRCUMSTANCES_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, CIRCUMSTANCES_NAME, JUSTIFIABLE_FORCE_ID, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off, NIBRS_JUSTIFIABLE_FORCE,by= "JUSTIFIABLE_FORCE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, CIRCUMSTANCES_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_VICTIM_INJURY,by="VICTIM_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, CIRCUMSTANCES_NAME, INJURY_ID, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_INJURY,by="INJURY_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_ID, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_VICTIM_TYPE,by="VICTIM_TYPE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_NAME, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID)

off<-full_join(off,NIBRS_VICTIM_OFFENDER_REL,by="VICTIM_ID") %>%
  select('OFFENDER_ID.x', OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_NAME, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID, RELATIONSHIP_ID)

off<-rename(off,OFFENDER_ID=OFFENDER_ID.x)

off<-full_join(off,NIBRS_RELATIONSHIP,by="RELATIONSHIP_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, RACE_DESC, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_NAME, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_ID, VIC_ETHNICITY_ID, RELATIONSHIP_CODE, RELATIONSHIP_NAME)

##########
# summary datasets

arr_sum <- arr %>%
  group_by(OFFENSE_CATEGORY_NAME) %>%
  summarise(n_arr=n())

off_sum <- off %>%
  group_by(OFFENSE_CATEGORY_NAME) %>%
  summarise(n_off=n())

arr_off_sum <- full_join(arr_sum,off_sum,by="OFFENSE_CATEGORY_NAME")

arr_off_sum <- arr_off_sum %>% 
  pivot_longer(c(`n_arr`, `n_off`), names_to = "Dataset", values_to = "n")

arr_race <- arr %>%
  group_by(RACE_CODE) %>%
  summarise(n_arr=n())

arr_race <- arr_race %>%
  mutate(Percent_of_arrest_data=(n_arr/nrow(arr))*100)

off_race <- off %>%
  group_by(RACE_CODE) %>%
  summarise(n_off=n())

off_race <- off_race %>%
  mutate(Percent_of_offender_data=(n_off/nrow(off))*100)

arr_off_race <- full_join(arr_race,off_race,by="RACE_CODE")

percent_population <- tibble("Percent_of_MN_population"=c(5.2,NA,7,NA,1.4,NA,2.6,NA,NA,0.1,NA,83.8,NA))

arr_off_race <- arr_off_race %>%
  add_column(percent_population)

arr_off_race <- arr_off_race %>%
  rename("Percent_of_MN_population"='percent_population')

arr_off_race <- full_join(arr_off_race,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n_arr,Percent_of_arrest_data,n_off,Percent_of_offender_data,Percent_of_MN_population)

arr_off_race <- arr_off_race %>% 
  rename("n_arrestees"="n_arr","n_offenders"="n_off")

off<-off %>% select(-RACE_DESC)

arr_off_race <- arr_off_race %>%
  filter(n_arrestees>1)

arr_off_race <- arr_off_race %>%
  rename("Race"="RACE_DESC","Percent_of_arrestees"="Percent_of_arrest_data",
         "Percent_of_offenders"="Percent_of_offender_data")

percent_population2 <- tibble("Percent_of_MN_population"=c(5.2,7,1.4,0.1,NA,83.8,NA),
                              "RACE_CODE"=c("A","B","I","P","U","W",NA))

animal_cruelty<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Animal Cruelty") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
animal_cruelty <- animal_cruelty %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
animal_cruelty<-full_join(animal_cruelty,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
animal_cruelty <- left_join(animal_cruelty,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

arson<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Arson") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
arson <- arson %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
arson <- full_join(arson,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
arson <- left_join(arson,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

assault<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Assault Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
assault <- assault %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
assault <- full_join(assault,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
assault <- left_join(assault,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

bad_checks<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Bad Checks") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
bad_checks <- bad_checks %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
bad_checks <- full_join(bad_checks,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
bad_checks <- left_join(bad_checks,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

bribery<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Bribery") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
bribery <- bribery %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
bribery <- full_join(bribery,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
bribery <- left_join(bribery,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

burglary<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Burglary/Breaking & Entering") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
burglary <- burglary %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
burglary <- full_join(burglary,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
burglary <- left_join(burglary,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

counterfeiting<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Counterfeiting/Forgery") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
counterfeiting <- counterfeiting %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
counterfeiting <- full_join(counterfeiting,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
counterfeiting <- left_join(counterfeiting,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

loitering<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Curfew/Loitering/Vagrancy Violations") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
loitering <- loitering %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
loitering <- full_join(loitering,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
loitering <- left_join(loitering,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

vandalism<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Destruction/Damage/Vandalism of Property") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
vandalism <- vandalism %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
vandalism <- full_join(vandalism,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
vandalism <- left_join(vandalism,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

disorderly_conduct<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Disorderly Conduct") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
disorderly_conduct <- disorderly_conduct %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
disorderly_conduct <- full_join(disorderly_conduct,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
disorderly_conduct <- left_join(disorderly_conduct,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

DUI<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Disorderly Conduct") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
DUI <- DUI %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
DUI <- full_join(DUI,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
DUI <- left_join(DUI,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

drug_offenses<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Drug/Narcotic Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
drug_offenses <- drug_offenses %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
drug_offenses <- full_join(drug_offenses,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
drug_offenses <- left_join(drug_offenses,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

drunkenness<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Drunkenness") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
drunkenness <- drunkenness %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
drunkenness <- full_join(drunkenness,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
drunkenness <- left_join(drunkenness,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

embezzlement<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Embezzlement") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM,na.rm=TRUE))
embezzlement <- embezzlement %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
embezzlement <- full_join(embezzlement,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
embezzlement <- left_join(embezzlement,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

extortion<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Extortion/Blackmail") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM,na.rm=TRUE))
extortion <- extortion %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
extortion <- full_join(extortion,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
extortion <- left_join(extortion,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

nonviolent_family_offenses<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Family Offenses, Nonviolent") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
nonviolent_family_offenses <- nonviolent_family_offenses %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
nonviolent_family_offenses <- full_join(nonviolent_family_offenses,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
nonviolent_family_offenses <- left_join(nonviolent_family_offenses,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

fraud<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Fraud Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
fraud <- fraud %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
fraud <- full_join(fraud,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
fraud <- left_join(fraud,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)


homicide<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Homicide Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
homicide <- homicide %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
homicide <- full_join(homicide,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
homicide <- left_join(homicide,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

human_trafficking<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Human Trafficking") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
human_trafficking <- human_trafficking %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
human_trafficking <- full_join(human_trafficking,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
human_trafficking <- left_join(human_trafficking,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

kidnapping<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Kidnapping/Abduction") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
kidnapping <- kidnapping %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
kidnapping <- full_join(kidnapping,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
kidnapping <- left_join(kidnapping,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

liquor_law_violations<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Liquor Law Violations") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
liquor_law_violations <- liquor_law_violations %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
liquor_law_violations <- full_join(liquor_law_violations,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
liquor_law_violations <- left_join(liquor_law_violations,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

vehicle_theft<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Motor Vehicle Theft") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
vehicle_theft <- vehicle_theft %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
vehicle_theft <- full_join(vehicle_theft,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
vehicle_theft <- left_join(vehicle_theft,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

other_offenses<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Other Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
other_offenses <- other_offenses %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
other_offenses <- full_join(other_offenses,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
other_offenses <- left_join(other_offenses,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

peeping_tom<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Peeping Tom") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
peeping_tom <- peeping_tom %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
peeping_tom <- full_join(peeping_tom,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
peeping_tom <- left_join(peeping_tom,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

obscene_material<-off %>%
  filter(OFFENSE_CATEGORY_NAME=="Pornography/Obscene Material") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
obscene_material <- obscene_material %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
obscene_material <- full_join(obscene_material,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
obscene_material <- left_join(obscene_material,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

prostitution <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Prostitution Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
prostitution <- prostitution %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
prostitution <- full_join(prostitution,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
prostitution <- left_join(prostitution,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)


robbery <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Robbery") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
robbery <- robbery %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
robbery <- full_join(robbery,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
robbery <- left_join(robbery,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

sex_offenses <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Sex Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
sex_offenses <- sex_offenses %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
sex_offenses <- full_join(sex_offenses,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
sex_offenses <- left_join(sex_offenses,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

sex_offenses_nonforcible <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Sex Offenses, Non-forcible") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
sex_offenses_nonforcible <- sex_offenses_nonforcible %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
sex_offenses_nonforcible <- full_join(sex_offenses_nonforcible,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
sex_offenses_nonforcible <- left_join(sex_offenses_nonforcible,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

stolen_property <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Stolen Property Offenses") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
stolen_property <- stolen_property %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
stolen_property <- full_join(stolen_property,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
stolen_property <- left_join(stolen_property,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

weapon_law_violations <- off %>%
  filter(OFFENSE_CATEGORY_NAME=="Weapon Law Violations") %>%
  group_by(RACE_CODE) %>%
  summarise(n=n(),mean_age=mean(AGE_NUM))
weapon_law_violations <- weapon_law_violations %>%
  mutate(Percent_of_offenders = (n/sum(n))*100)
weapon_law_violations <- full_join(weapon_law_violations,percent_population2,by="RACE_CODE") %>%
  select(RACE_CODE,n,mean_age,Percent_of_offenders,Percent_of_MN_population)
weapon_law_violations <- left_join(weapon_law_violations,REF_RACE,by="RACE_CODE") %>%
  select(RACE_DESC,n,mean_age,Percent_of_offenders,Percent_of_MN_population) %>%
  rename(Race=RACE_DESC)

off<-off %>% rename(RACE_ID=VIC_RACE_ID)
REF_RACE <- REF_RACE %>% rename(VIC_RACE_CODE = RACE_CODE)

off<-left_join(off,REF_RACE,by="RACE_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, ETHNICITY_CODE, ETHNICITY_NAME,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_NAME, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_CODE, VIC_ETHNICITY_ID, RELATIONSHIP_CODE, RELATIONSHIP_NAME)

REF_RACE <- REF_RACE %>% rename(RACE_CODE = VIC_RACE_CODE)

off<-off %>% rename(ETHNICITY_ID=VIC_ETHNICITY_ID)
NIBRS_ETHNICITY <- NIBRS_ETHNICITY %>% rename(VIC_ETHNICITY_CODE = ETHNICITY_CODE)

off<-left_join(off,NIBRS_ETHNICITY,by="ETHNICITY_ID") %>%
  select(OFFENDER_ID, OFFENSE_ID, INCIDENT_ID, OFFENSE_NAME, CRIME_AGAINST, OFFENSE_CATEGORY_NAME, CRIMINAL_ACT_CODE, CRIMINAL_ACT_NAME, LOCATION_NAME, AGE_NUM, SEX_CODE, RACE_CODE, ETHNICITY_CODE,BIAS_CATEGORY,BIAS_DESC, PROPERTY_ID, PROP_LOSS_NAME, STOLEN_COUNT, RECOVERED_COUNT, PROP_DESC_NAME, PROPERTY_VALUE, VICTIM_ID, VICTIM_TYPE_NAME, CIRCUMSTANCES_NAME, INJURY_NAME, JUSTIFIABLE_FORCE_CODE, JUSTIFIABLE_FORCE_NAME, ASSIGNMENT_TYPE_NAME, VIC_AGE_NUM, VIC_SEX_CODE, VIC_RACE_CODE, VIC_ETHNICITY_CODE, RELATIONSHIP_CODE, RELATIONSHIP_NAME)

NIBRS_ETHNICITY <- NIBRS_ETHNICITY %>% rename(ETHNICITY_CODE = VIC_ETHNICITY_CODE)

######################
# WaPo police shootings data

fatal_police_shootings_data <- read_csv("fatal-police-shootings-data.csv")

shootings_mn <- fatal_police_shootings_data %>%
  filter(state=="MN")
shootings_mn <- shootings_mn %>%
  separate('date',into=c("Year","Month","Day"))


ui <- navbarPage("Crime and Policing in Minnesota",
                 tabPanel("Arrests",
                          sidebarLayout(
                              sidebarPanel(
                                  varSelectInput("var", "Variable (Tab 1)",arr[,4:5]),
                                  varSelectInput("var2","Variable",arr[,7:9])
                              ),
                              mainPanel(
                                  h2("Arrestees"),
                                  tabsetPanel(
                                      tabPanel("Tab 1",plotOutput("plot1",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native, 
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese, 
                                               Native Hawaiian or Other Pacific Islander, O=other,
                                               M=multiple, U=unknown, NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")
                                      ),
                                      tabPanel("Tab 2",plotOutput("plot2",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native, 
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese, 
                                               Native Hawaiian or Other Pacific Islander, O=other,
                                               M=multiple, U=unknown, NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown"))
                                      )
                                      
                                  )
                              )
                          ),
                 tabPanel("Arrests cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var3","Offense category",
                                              c("Animal Cruelty"="Animal Cruelty",
                                                "Arson"="Arson",
                                                "Assault Offenses"="Assault Offenses",
                                                "Bad Checks"="Bad Checks",
                                                "Bribery"="Bribery",
                                                "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                                "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                                "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                                "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                                "Disorderly Conduct"="Disorderly Conduct",
                                                "Driving Under the Influence"="Driving Under the Influence",
                                                "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                                "Drunkenness"="Drunkenness",
                                                "Embezzlement"="Embezzlement",
                                                "Extortion/Blackmail"="Extortion/Blackmail",
                                                "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                                "Fraud Offenses"="Fraud Offenses",
                                                "Gambling Offenses"="Gambling Offenses",
                                                "Homicide Offenses"="Homicide Offenses",
                                                "Human Trafficking"="Human Trafficking",
                                                "Kidnapping/Abduction"="Kidnapping/Abduction",
                                                "Liquor Law Violations"="Liquor Law Violations",
                                                "Motor Vehicle Theft"="Motor Vehicle Theft",
                                                "Other Offenses"="Other Offenses",
                                                "Peeping Tom"="Peeping Tom",
                                                "Pornography/Obscene Material"="Pornography/Obscene Material",
                                                "Prostitution Offenses"="Prostitution Offenses",
                                                "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                                "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                                "Stolen Property Offenses"="Stolen Property Offenses",
                                                "Weapon Law Violations")),
                                  sliderInput("bins",
                                              "Number of bins (Tab 2):",
                                              min = 1,
                                              max = 50,
                                              value = 30)
                              ),
                              mainPanel(
                                  h2("Arrestees"),
                                  tabsetPanel(
                                      tabPanel("Tab 1",plotOutput("plot3",inline=TRUE),
                                               h5("Sex codes:"),
                                               p("M=male, F=female"),
                                               h5("Race codes:"),
                                               p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                               h5("Ethnicity codes:"),
                                               p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")),
                                      tabPanel("Tab 2",plotOutput("plot4",inline=TRUE))
                                  )
                              )
                          )),
                          tabPanel("Offenders",
                                   sidebarLayout(
                                       sidebarPanel(
                                           varSelectInput("var6","Variable",off[,11:13]),
                                           selectInput("var7","Offense category (Tab 2)",
                                                                c("Animal Cruelty"="Animal Cruelty",
                                                                  "Arson"="Arson",
                                                                  "Assault Offenses"="Assault Offenses",
                                                                  "Bad Checks"="Bad Checks",
                                                                  "Bribery"="Bribery",
                                                                  "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                                                  "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                                                  "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                                                  "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                                                  "Disorderly Conduct"="Disorderly Conduct",
                                                                  "Driving Under the Influence"="Driving Under the Influence",
                                                                  "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                                                  "Drunkenness"="Drunkenness",
                                                                  "Embezzlement"="Embezzlement",
                                                                  "Extortion/Blackmail"="Extortion/Blackmail",
                                                                  "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                                                  "Fraud Offenses"="Fraud Offenses",
                                                                  "Gambling Offenses"="Gambling Offenses",
                                                                  "Homicide Offenses"="Homicide Offenses",
                                                                  "Human Trafficking"="Human Trafficking",
                                                                  "Kidnapping/Abduction"="Kidnapping/Abduction",
                                                                  "Liquor Law Violations"="Liquor Law Violations",
                                                                  "Motor Vehicle Theft"="Motor Vehicle Theft",
                                                                  "Other Offenses"="Other Offenses",
                                                                  "Peeping Tom"="Peeping Tom",
                                                                  "Pornography/Obscene Material"="Pornography/Obscene Material",
                                                                  "Prostitution Offenses"="Prostitution Offenses",
                                                                  "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                                                  "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                                                  "Stolen Property Offenses"="Stolen Property Offenses",
                                                                  "Weapon Law Violations")),
                                           
                                           sliderInput("bins2",
                                                       "Number of bins (tab 2):",
                                                       min = 1,
                                                       max = 50,
                                                       value = 30)

                                       ),
                                       
                                       mainPanel(
                                           h2("Offenders"),
                                           tabsetPanel(
                                               tabPanel("Tab 1",plotOutput("plot5",inline=TRUE),
                                                        h5("Sex codes:"),
                                                        p("M=male, F=female"),
                                                        h5("Race codes:"),
                                                        p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                                        h5("Ethnicity codes:"),
                                                        p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown")),
                                               tabPanel("Tab 2",plotOutput("plot6",inline=TRUE),
                                                        h5("Sex codes:"),
                                                        p("M=male, F=female"),
                                                        h5("Race codes:"),
                                                        p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian,AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                                        h5("Ethnicity codes:"),
                                                        p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown"))
                                               
                                           )
                                       )
                                   )
                          ),
                 tabPanel("Offenders, cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var8","Offense category",
                                              c("Animal Cruelty",
                                                "Arson",
                                                "Assault Offenses",
                                                "Bad Checks",
                                                "Bribery",
                                                "Burglary/Breaking & Entering",
                                                "Counterfeiting/Forgery",
                                                "Curfew/Loitering/Vagrancy Violations",
                                                "Destruction/Damage/Vandalism of Property",
                                                "Disorderly Conduct",
                                                "Driving Under the Influence",
                                                "Drug/Narcotic Offenses",
                                                "Drunkenness",
                                                "Embezzlement",
                                                "Extortion/Blackmail",
                                                "Family Offenses, Nonviolent",
                                                "Fraud Offenses",
                                                "Gambling Offenses",
                                                "Homicide Offenses",
                                                "Human Trafficking",
                                                "Kidnapping/Abduction",
                                                "Liquor Law Violations",
                                                "Motor Vehicle Theft",
                                                "Other Offenses",
                                                "Peeping Tom",
                                                "Pornography/Obscene Material",
                                                "Prostitution Offenses",
                                                "Robbery","Sex Offenses",
                                                "Sex Offenses, Non-forcible",
                                                "Stolen Property Offenses",
                                                "Weapon Law Violations"
                                                )),
                                  actionButton("update", "Update view")
                                  
                          ),
                          mainPanel(
                              h2("Offenders"),
                              tabPanel("Table",
                                       tableOutput("table2"))
                          )
                 )
                 ),
            navbarMenu("More",
                 tabPanel("Offenders, cont.",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var9","Offense category",
                                              c("Animal Cruelty"="Animal Cruelty",
                                                "Arson"="Arson",
                                                "Assault Offenses"="Assault Offenses",
                                                "Bad Checks"="Bad Checks",
                                                "Bribery"="Bribery",
                                                "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                                "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                                "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                                "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                                "Disorderly Conduct"="Disorderly Conduct",
                                                "Driving Under the Influence"="Driving Under the Influence",
                                                "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                                "Drunkenness"="Drunkenness",
                                                "Embezzlement"="Embezzlement",
                                                "Extortion/Blackmail"="Extortion/Blackmail",
                                                "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                                "Fraud Offenses"="Fraud Offenses",
                                                "Gambling Offenses"="Gambling Offenses",
                                                "Homicide Offenses"="Homicide Offenses",
                                                "Human Trafficking"="Human Trafficking",
                                                "Kidnapping/Abduction"="Kidnapping/Abduction",
                                                "Liquor Law Violations"="Liquor Law Violations",
                                                "Motor Vehicle Theft"="Motor Vehicle Theft",
                                                "Other Offenses"="Other Offenses",
                                                "Peeping Tom"="Peeping Tom",
                                                "Pornography/Obscene Material"="Pornography/Obscene Material",
                                                "Prostitution Offenses"="Prostitution Offenses",
                                                "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                                "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                                "Stolen Property Offenses"="Stolen Property Offenses",
                                                "Weapon Law Violations")),
                                  
                                  varSelectInput("var10","Variable (tab 2)", off[,24:26])
                              ),
                                  
                              mainPanel(
                                  h2("Offenders"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",plotOutput("plot7")),
                                  tabPanel("Tab 2",plotOutput("plot8"))
                                  
                              )
                              )
                          )
                 ),
                 tabPanel("Victims",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var11", "Offense category", 
                                   c("Animal Cruelty"="Animal Cruelty",
                                  "Arson"="Arson",
                                  "Assault Offenses"="Assault Offenses",
                                  "Bad Checks"="Bad Checks",
                                  "Bribery"="Bribery",
                                  "Burglary/Breaking & Entering"="Burglary/Breaking & Entering",
                                  "Counterfeiting/Forgery"="Counterfeiting/Forgery",
                                  "Curfew/Loitering/Vagrancy Violations"="Curfew/Loitering/Vagrancy Violations",
                                  "Destruction/Damage/Vandalism of Property"="Destruction/Damage/Vandalism of Property",
                                  "Disorderly Conduct"="Disorderly Conduct",
                                  "Driving Under the Influence"="Driving Under the Influence",
                                  "Drug/Narcotic Offenses"="Drug/Narcotic Offenses",
                                  "Drunkenness"="Drunkenness",
                                  "Embezzlement"="Embezzlement",
                                  "Extortion/Blackmail"="Extortion/Blackmail",
                                  "Family Offenses, Nonviolent"="Family Offenses, Nonviolent",
                                  "Fraud Offenses"="Fraud Offenses",
                                  "Gambling Offenses"="Gambling Offenses",
                                  "Homicide Offenses"="Homicide Offenses",
                                  "Human Trafficking"="Human Trafficking",
                                  "Kidnapping/Abduction"="Kidnapping/Abduction",
                                  "Liquor Law Violations"="Liquor Law Violations",
                                  "Motor Vehicle Theft"="Motor Vehicle Theft",
                                  "Other Offenses"="Other Offenses",
                                  "Peeping Tom"="Peeping Tom",
                                  "Pornography/Obscene Material"="Pornography/Obscene Material",
                                  "Prostitution Offenses"="Prostitution Offenses",
                                  "Robbery"="Robbery","Sex Offenses"="Sex Offenses",
                                  "Sex Offenses, Non-forcible"="Sex Offenses, Non-forcible",
                                  "Stolen Property Offenses"="Stolen Property Offenses",
                                  "Weapon Law Violations")),
                                  varSelectInput("var12","Variable (tab 2)",
                                                 off %>% select(SEX_CODE,RACE_CODE,ETHNICITY_CODE)),
                                  varSelectInput("var13","Variable (tab 2)",
                                                 off %>% select(VIC_SEX_CODE,VIC_RACE_CODE,
                                                                VIC_ETHNICITY_CODE))
                              ),
                              mainPanel(
                                  h2("Victims"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",plotOutput("plot9"),
                                           p("n="),verbatimTextOutput("n"),
                                           plotOutput("plot10"),inline=TRUE),
                                  tabPanel("Tab 2",plotOutput("plot11"),inline=TRUE,
                                           h5("Sex codes:"),
                                           p("M=male, F=female"),
                                           h5("Race codes:"),
                                           p("W=white, B=Black, I=American Indian or Alaska Native,
                                               A=Asian, AP=Asian, Native Hawaiian, or Other Pacific Islander,
                                               C=Chinese, J=Japanese,
                                               Native Hawaiian or Other Pacific Islander, O=other, 
                                               M=multiple, U=unknown,
                                                 NS=not specified"),
                                           h5("Ethnicity codes:"),
                                           p("M=multiple, H=Hispanic or Latino, 
                                                 N=Not Hispanic or Latino, U=unknown"))))
                              )
                          ),
                 tabPanel("Fatal police shootings",
                          sidebarLayout(
                              sidebarPanel(
                                  selectInput("var14","Year",
                                              c("2015","2016","2017","2018","2019","2020")),
                                  varSelectInput("var15","Variable (tabs 2, 3)",
                                                 shootings_mn %>% 
                                                     select(manner_of_death,armed,gender,
                                                            race,signs_of_mental_illness,threat_level,
                                                            flee,body_camera))
                              ),
                              mainPanel(
                                  h2("Fatal police shootings"),
                                  tabsetPanel(
                                  tabPanel("Tab 1",dataTableOutput("table3"),inline=TRUE),
                                  tabPanel("Tab 2",plotOutput("plot12"),inline=TRUE),
                                  tabPanel("Tab 3",plotOutput("plot13"),inline=TRUE)
                              )
                              )
                          )
                 ),
                 tabPanel("About",
                          h2("About"),
                          p("This shiny app was created by Sam Carlen (github.com/samcarlen). The data primarily comes from the FBI's National Incident-Based Reporting System (https://www.fbi.gov/services/cjis/ucr/nibrs). The data on fatal police shootings comes from the Washington Post's police shootings database (https://www.washingtonpost.com/graphics/investigations/police-shootings-database/).")
                          )
                 )
)


                                     
# Define server logic required to draw a histogram
server <- function(input, output, session) {
    output$plot1 <- renderPlot({
        
        arr %>%
            ggplot()+geom_bar(aes(!!input$var,fill=!!input$var2))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot2 <- renderPlot({
        arr %>%
            ggplot()+geom_histogram(aes(x=AGE_NUM,fill=!!input$var2))+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot3<- renderPlot({
        arr %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot()+geom_bar(aes(x=RACE_CODE,fill=RACE_CODE))+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot4<-renderPlot({
        arr %>%
            filter(OFFENSE_CATEGORY_NAME==input$var3) %>%
            ggplot() + geom_histogram(aes(x=AGE_NUM),bins = input$bins)+
            theme_bw()
        
    },width=500,height=700)
    
    output$plot5 <- renderPlot({
        off %>%
            ggplot()+geom_bar(aes(OFFENSE_CATEGORY_NAME,fill=!!input$var6))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    },width=500,height=700)
    
    output$plot6<-renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var7) %>%
            ggplot() + geom_histogram(aes(x=AGE_NUM,fill=!!input$var6),bins=input$bins2)
    },width=500,height=700)
    
    
    datasetInput <- eventReactive(input$update, {
        switch(input$var8,
               "Animal Cruelty"=animal_cruelty,
               "Arson"=arson,
               "Assault Offenses"=assault,
               "Bad Checks"=bad_checks,
               "Bribery"=bribery,
               "Burglary/Breaking & Entering"=burglary,
               "Counterfeiting/Forgery"=counterfeiting,
               "Curfew/Loitering/Vagrancy Violations"=loitering,
               "Destruction/Damage/Vandalism of Property"=vandalism,
               "Disorderly Conduct"=disorderly_conduct,
               "Driving Under the Influence"=DUI,
               "Drug/Narcotic Offenses"=drug_offenses,
               "Drunkenness"=drunkenness,
               "Embezzlement"=embezzlement,
               "Extortion/Blackmail"=extortion,
               "Family Offenses, Nonviolent"=nonviolent_family_offenses,
               "Fraud Offenses"=fraud,
               "Gambling Offenses"=gambling_offenses,
               "Homicide Offenses"=homicide,
               "Human Trafficking"=human_trafficking,
               "Kidnapping/Abduction"=kidnapping,
               "Liquor Law Violations"=liquor_law_violations,
               "Motor Vehicle Theft"=vehicle_theft,
               "Other Offenses"=other_offenses,
               "Peeping Tom"=peeping_tom,
               "Pornography/Obscene Material"=obscene_material,
               "Prostitution Offenses"=prostitution,
               "Robbery"=robbery,"Sex Offenses"=sex_offenses,
               "Sex Offenses, Non-forcible"=sex_offenses_nonforcible,
               "Stolen Property Offenses"=stolen_property,
               "Weapon Law Violations"=weapon_law_violations)}, ignoreNULL = FALSE)

    output$table2 <- renderTable({
        head(datasetInput(), n = 10)
    })
    
    output$plot7 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var9) %>%
            ggplot()+geom_bar(aes(LOCATION_NAME))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
            
    })
    
    output$plot8 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var9) %>%
            ggplot()+geom_bar(aes(x=!!input$var10))+
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
    output$plot9 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11) %>%
            ggplot()+
            geom_density(aes(x=AGE_NUM,color="red"),stat="density")+
            geom_density(aes(x=VIC_AGE_NUM,color="blue"),stat="density")+
            theme_bw() +
            theme(legend.position = "bottom")+
            scale_color_discrete(labels = c("Offender age", "Victim age"))
    })
    
    output$plot10 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11) %>%
            ggplot()+
            geom_bar(aes(x=RELATIONSHIP_NAME)) +
            coord_flip()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    output$n <- renderPrint({
        o<-off %>%
            filter(OFFENSE_CATEGORY_NAME==input$var11)
        nrow(o)
    })

    output$plot11 <- renderPlot({
        off %>%
            filter(OFFENSE_CATEGORY_NAME==!!input$var11) %>%
            ggplot(aes(x=!!input$var12,y=!!input$var13)) +
            geom_count()+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
    output$table3 <- renderDataTable(
        shootings_mn %>%
            filter(Year==!!input$var14)
    )
    
    output$plot12 <- renderPlot({
        shootings_mn %>%
            ggplot() + geom_bar(aes(x=Year,fill=!!input$var15))+
            theme_bw()+
            theme(legend.position = "bottom")
            
    })
    
    output$plot13 <- renderPlot({
        shootings_mn %>%
            ggplot() + geom_boxplot(aes(x=!!input$var15,y=age))+
            theme_bw()+
            theme(legend.position = "bottom")
    })
    
}

shinyApp(ui = ui, server = server)
