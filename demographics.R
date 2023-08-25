library(tidyverse)
getwd()
setwd("/Users/jannatulashpia/Documents/")
#Read the files
get_13_18 <- read_csv('2013_-_2018_Demographic_Snapshot_Borough.csv')
get_12_21 <- read_csv('2020-2021_Demographic_Snapshot_Borough.csv')

#clean up 13_18
colnames(get_13_18) <- ( gsub(" ", "_", colnames(get_13_18))) #REMOVE WHITESPACE
colnames(get_13_18) <- ( gsub("%", "percent", colnames(get_13_18))) #REMOVE %
colnames(get_13_18) <- ( gsub("#", "num", colnames(get_13_18))) #REMOVE

new_13_18 <- get_13_18 %>% 
  mutate(percent_Native_American = NA, 
         num_Native_American = NA, 
         percent_Multi_Racial = NA, 
         num_Multi_Racial = NA) %>% 
  select(-`Grade_PK_(Half_Day_&_Full_Day)`)

#clean up 12_21
colnames(get_12_21) <- ( gsub(" ", "_", colnames(get_12_21))) #REMOVE WHITESPACE
colnames(get_12_21) <- ( gsub("-", "_", colnames(get_12_21))) #REMOVE WHITESPACE
colnames(get_12_21) <- ( gsub("%", "percent", colnames(get_12_21))) #REMOVE %
colnames(get_12_21) <- ( gsub("#", "num", colnames(get_12_21))) #REMOVE



new_12_21 <- get_12_21 %>% 
  select(-`percent_Missing_Race/Ethnicity_Data`, 
         -`num_Missing_Race/Ethnicity_Data`, 
         -`Grade_3K+PK_(Half_Day_&_Full_Day)`) %>% 
  mutate(num_Multiple_Race_Categories_Not_Represented = NA, 
         percent_Multiple_Race_Categories_Not_Represented = NA)

combined_df <- rbind(new_13_18, new_12_21) #single frame

grouped_data <- combined_df %>% 
  select(1:3, 17:32, 35:41)

final_df <- grouped_data %>% 
  group_by(Borough) %>%
  arrange(Borough)

write.csv(final_df, "output_file.csv", row.names = FALSE)

