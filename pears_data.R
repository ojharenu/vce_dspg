#READING IN THE PEARS RAW DATA, ACTION PLAN, AND OUTCOME INDICATORS

install.packages("readxl")

library(readxl)
library(dplyr)

setwd("C:/Users/jeffr/Desktop/diego_and_jeffrey_initial_vce_data")

pears_action_plan <- read_excel("PEARS Raw Data 5.23.25.xlsx", sheet = "Program Activities")

pears_action_plan_data <- read_excel("PEARS Action-Plans-Export 5.30.25.xlsx", sheet = "Action Plan Data")

pears_outcome_indicators <- read_excel("PEARS Action-Plans-Export 5.30.25.xlsx", sheet = "Outcome Indicators")

pears_raw_data_codebook <- read_excel("PEARS Raw Data 5.23.25.xlsx", sheet = "Program Activities Codebook")

pears_action_plan_codebook <- read_excel("PEARS Action-Plans-Export 5.30.25.xlsx", sheet = "Codebook")



# June 9 2025 -------------------------------------------------------------

#IDEA: COMPARE THE PARTICIPANTS LISTED IN THE PEARS DATA WITH THE DEMOGRAPHIC DATA
#CREATED A NEW R SCRIPT FOR THIS

#SUMMING UP PARTICIPATION RATES BY ETHNICITY

library(dplyr)
library(tidycensus)
library(tidyverse)
library(readxl)

getwd()
list.files()

pears_raw_ethnic_data <- read_excel("PEARS Raw Data 5.23.25.xlsx", sheet = "Program Activities")

program_activities_ethnicity_count <- pears_raw_ethnic_data

head(program_activities_ethnicity_count)

total_hispanic <- sum(program_activities_ethnicity_count$participants_ethnicity_hispanic, na.rm = TRUE)
total_non_hispanic <- sum(program_activities_ethnicity_count$participants_ethnicity_non_hispanic, na.rm = TRUE)
total_unknown_ethnicity <- sum(program_activities_ethnicity_count$participants_ethnicity_unknown, na.rm = TRUE)
test_do_not_reference <- sum(program_activities_ethnicity_count$participants_ethnicity_prefer_not_to_respond, na.rm = TRUE)
total_onerace_native_american <- sum(program_activities_ethnicity_count$participants_amerind_onerace_total, na.rm = TRUE)
total_multirace_native_american <- sum(program_activities_ethnicity_count$participants_amerind_multirace_total, na.rm = TRUE)
total_asian_onerace <- sum(program_activities_ethnicity_count$participants_asian_onerace_total, na.rm = TRUE)
total_asian_multirace <- sum(program_activities_ethnicity_count$participants_asian_multirace_total, na.rm = TRUE)
total_black_onerace <- sum(program_activities_ethnicity_count$participants_black_onerace_total, na.rm = TRUE)
total_black_multirace <- sum(program_activities_ethnicity_count$participants_black_multirace_total, na.rm = TRUE)
total_hawpac_onerace <- sum(program_activities_ethnicity_count$participants_hawpac_onerace_total, na.rm = TRUE)
total_hawpac_multirace_updated <- sum(program_activities_ethnicity_count$participants_hawpac_multirace_total, na.rm = TRUE)
total_white_onerace <- sum(program_activities_ethnicity_count$participants_white_onerace_total, na.rm = TRUE)
total_white_multirace <- sum(program_activities_ethnicity_count$participants_white_multirace_total, na.rm = TRUE)

participants_race_nativeamerican <- sum(program_activities_ethnicity_count$participants_race_amerind, na.rm = TRUE)
participants_race_asian <- sum(program_activities_ethnicity_count$participants_race_asian, na.rm = TRUE)
participants_race_black <- sum(program_activities_ethnicity_count$participants_race_black, na.rm = TRUE)
participants_race_hawpac <- sum(program_activities_ethnicity_count$participants_race_hawpac, na.rm = TRUE)
participants_race_white <- sum(program_activities_ethnicity_count$participants_race_white, na.rm = TRUE)
participants_race_two_or_more <- sum(program_activities_ethnicity_count$participants_race_two_or_more, na.rm = TRUE)
participants_race_no_response <- sum(program_activities_ethnicity_count$participants_race_prefer_not_to_respond, na.rm = TRUE)
participants_race_unknown <- sum(program_activities_ethnicity_count$participants_race_unknown, na.rm = TRUE)

total_participation <- sum(ethnicity_totals_statewide)

ethnicity_totals <- rbind(total_hispanic,total_non_hispanic,total_unknown_ethnicity,total_onerace_native_american,
      total_multirace_native_american,total_asian_onerace,total_asian_multirace,
      total_black_onerace,total_black_multirace,total_hawpac_onerace, total_hawpac_multirace_updated,
      total_white_onerace,total_white_multirace,participants_race_nativeamerican,
    participants_race_asian, participants_race_black, participants_race_hawpac,
    participants_race_white,participants_race_two_or_more, participants_race_no_response,
    participants_race_unknown)

ethnicity_totals_statewide <- ethnicity_totals

#CREATING AN INTERACTIVE DATA SET

install.packages("DataExplorer")
library(DataExplorer)
interactive_data_table <- data.frame(list("Total Hispanic Participation" = total_hispanic, "Total Non-Hispanic Participants" = total_non_hispanic,
               "Total Participants of Unknown Ethnicity" = total_unknown_ethnicity,
               "Participants Ethnicity - Prefer Not To Respond" = test_do_not_reference,
               "Total Participants of Native American Descent - One Race" = total_onerace_native_american,
               "Total Participants of Native American Descent - Multirace" = total_multirace_native_american,
               "Total Participants Asian Descent - One Race" = total_asian_onerace,
               "Total Participants of Asian Descent - Multirace" = total_asian_multirace,
               "Total Participants - African American, One Race" = total_black_onerace,
               "Total Participants - African American, Multirace" = total_black_multirace,
               "Total Participants - Hawaiian/Pacific Islander - One Race" = total_hawpac_onerace,
               "Total Participants - Hawaiian/Pacific Islander - Multirace" = total_hawpac_multirace_updated,
               "Total Participants - White, One Race" = total_white_onerace,
               "Total Participants - White, Multirace" = total_white_multirace,
               "Participants Race - Native American" = participants_race_nativeamerican,
               "Participants Race - Asian" = participants_race_asian,
               "Participants Race - Black" = participants_race_black,
               "Participants Race - Hawaiian/Pacific Islander" = participants_race_hawpac,
               "Participants Race - White" = participants_race_white,
               "Participants Race - Two or More" = participants_race_two_or_more,
               "Participants Race - No Response" = participants_race_no_response,
               "Participants Race - Unknown" = participants_race_unknown))

row.names(ethnicity_totals_statewide) <- c("Total Hispanic Participation", "Total Non-Hispanic Participation",
                                           "Total Participation - Unknown Ethnicity", "Total Native American Participation - One Race",
                                           "Total Native American Participation - Multirace", "Total Asian Participation - One Race",
                                           "Total Asian Participation - Multirace", "Total African American Participation - One Race",
                                           "Total African American Participation - Multirace", "Total Hawaiian/Pacific Islander Participation - One Race",
                                           "Total Hawaiian/Pacific Islander Participation - Multirace", "Total White Participation - One Race",
                                           "Total White Participation - Multirace", "Attendees Reported as Native American", "Attendees Reported as Asian", "Attendees Reported as African American", "Attendees Reported as Hawaiian/Pacific Islander",
                                           "Attendees Reported as White", "Attendees Reported as having Two or More Races", "No Response", "Unknown")

# Change specific column name
print(colnames(ethnicity_totals_statewide))
colnames(ethnicity_totals_statewide) <- c("Ethnicities","Totals")
ncol(ethnicity_totals_statewide)

#GOT IT TO WORK BELOW

colnames(ethnicity_totals_statewide) <- "Totals"

new_column_values <- c("Total Hispanic Participation", "Total Non-Hispanic Participation",
                       "Total Participation - Unknown Ethnicity", "Total Native American Participation - One Race",
                       "Total Native American Participation - Multirace", "Total Asian Participation - One Race",
                       "Total Asian Participation - Multirace", "Total African American Participation - One Race",
                       "Total African American Participation - Multirace", "Total Hawaiian/Pacific Islander Participation - One Race",
                       "Total Hawaiian/Pacific Islander Participation - Multirace", "Total White Participation - One Race",
                       "Total White Participation - Multirace", "Attendees Reported as Native American", "Attendees Reported as Asian", "Attendees Reported as African American", "Attendees Reported as Hawaiian/Pacific Islander",
                       "Attendees Reported as White", "Attendees Reported as having Two or More Races", "No Response", "Unknown")

new_sheet <- cbind.data.frame(new_column_values, ethnicity_totals_statewide)

new_sheet2 <- rbind(new_sheet, ethnicity_totals_statewide)

