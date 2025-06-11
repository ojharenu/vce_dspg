#RENAME THE COLUMN HEADERS TAKE TWO BECAUSE APPARENTLY I CANNOT PROPERLY SAVE MY FILES

library(tidyverse)
library(dplyr)
library(tidycensus)
#2024 - 2025
Participation_2024_2025_thru_June_2 <- Participation_2024_2025_thru_June_2 %>%
  rename(
    "Youth Members of Organized 4-H Community Clubs" = "a",
    "Youth Members of Organized 4-H In-School Clubs" = "b",
    "Youth Members of Organized 4-H After School Clubs" = "c",
    "Youth Members of Military 4-H Clubs" = "d",
    "Total 4-H Club Membership" = "e",
    "Youth Participating in 4-H Special Interest/Short-Term Programs" = "f",
    "Youth Participating in 4-H Overnight Camping Programs" = "g",
    "Youth Participating in 4-H Day Camping Programs" = "h",
    "Total Youth Participating in 4-H Camping Programs" = "i",
    "Youth Participating in School Enrichment Programs" = "j",
    "Youth Participating in Individual Study/Mentoring/Family Learning Programs" = "k",
    "Youth Participating in After-School Programs Using 4-H Curricula/Staff Training" = "l",
    "Youth Participating in Instructional TV/Video/Web Programs" = "m",
    "County Totals" = "total",
    "County" = "CountyArea")

#2021 - 2022

Participation_2021_2022 <- Participation_2021_2022 %>%
  rename(
    "Youth Members of Organized 4-H Community Clubs" = "a",
    "Youth Members of Organized 4-H In-School Clubs" = "b",
    "Youth Members of Organized 4-H After School Clubs" = "c",
    "Youth Members of Military 4-H Clubs" = "d",
    "Total 4-H Club Membership" = "e",
    "Youth Participating in 4-H Special Interest/Short-Term Programs" = "f",
    "Youth Participating in 4-H Overnight Camping Programs" = "g",
    "Youth Participating in 4-H Day Camping Programs" = "h",
    "Total Youth Participating in 4-H Camping Programs" = "i",
    "Youth Participating in School Enrichment Programs" = "j",
    "Youth Participating in Individual Study/Mentoring/Family Learning Programs" = "k",
    "Youth Participating in After-School Programs Using 4-H Curricula/Staff Training" = "l",
    "Youth Participating in Instructional TV/Video/Web Programs" = "m",
    "County Totals" = "total",
    "County" = "CountyArea")

#2022 - 2023
Participation_2022_2023 <- Participation_2022_2023 %>%
  rename(
    "Youth Members of Organized 4-H Community Clubs" = "a",
    "Youth Members of Organized 4-H In-School Clubs" = "b",
    "Youth Members of Organized 4-H After School Clubs" = "c",
    "Youth Members of Military 4-H Clubs" = "d",
    "Total 4-H Club Membership" = "e",
    "Youth Participating in 4-H Special Interest/Short-Term Programs" = "f",
    "Youth Participating in 4-H Overnight Camping Programs" = "g",
    "Youth Participating in 4-H Day Camping Programs" = "h",
    "Total Youth Participating in 4-H Camping Programs" = "i",
    "Youth Participating in School Enrichment Programs" = "j",
    "Youth Participating in Individual Study/Mentoring/Family Learning Programs" = "k",
    "Youth Participating in After-School Programs Using 4-H Curricula/Staff Training" = "l",
    "Youth Participating in Instructional TV/Video/Web Programs" = "m",
    "County Totals" = "total",
    "County" = "CountyArea")

#2023 - 2024

Participation_2023_2024 <- Participation_2023_2024 %>%
  rename(
    "Youth Members of Organized 4-H Community Clubs" = "a",
    "Youth Members of Organized 4-H In-School Clubs" = "b",
    "Youth Members of Organized 4-H After School Clubs" = "c",
    "Youth Members of Military 4-H Clubs" = "d",
    "Total 4-H Club Membership" = "e",
    "Youth Participating in 4-H Special Interest/Short-Term Programs" = "f",
    "Youth Participating in 4-H Overnight Camping Programs" = "g",
    "Youth Participating in 4-H Day Camping Programs" = "h",
    "Total Youth Participating in 4-H Camping Programs" = "i",
    "Youth Participating in School Enrichment Programs" = "j",
    "Youth Participating in Individual Study/Mentoring/Family Learning Programs" = "k",
    "Youth Participating in After-School Programs Using 4-H Curricula/Staff Training" = "l",
    "Youth Participating in Instructional TV/Video/Web Programs" = "m",
    "County Totals" = "total",
    "County" = "CountyArea")

#NOW ATTEMPTING TO MERGE ALL FOUR EXCEL SHEETS INTO ONE VERTICAL SHEET
#THE LAYOUT WILL BE (LEFT - RIGHT) COUNTY, PROGRAMS YEAR

#OPENING AND INSTALLING NECESSARY PACKAGES

library(tidyverse)
library(dplyr)
library(readxl)
install.packages("purrr")
library(purrr)

#BEGINNING MERGE
#SETTING WORKING DIRECTORY TO WHERE THE EXCEL FILES ARE LOCATED (DOWNLOADS)

setwd("/Users/jeffreyogle/Participation_2021_2022.xlsx")

#FIXING ERROR BY HAVING IT JUST READ ALL OF MY DOWNLOADS BY USING THE LIST.FILES COMMAND

setwd("\\Users\\JeffreyOgle\\Downloads")
list.files()

#SELECTING FILES NOW

df_21_22 <- read_excel("Participation_2021_2022.xlsx", sheet = "Participation Count") %>%
  mutate(Year = "2021-2022")
df_22_23 <- read_excel("Participation_2022_2023.xlsx", sheet = "Participation Count") %>%
  mutate(Year = "2022-2023")
df_23_24 <- read_excel("Participation_2023_2024.xlsx", sheet = "Participation Count") %>%
  mutate(Year = "2023-2024")
df_24_25 <- read_excel("Participation_2024_2025_thru_June_2.xlsx", sheet = "Participation Count") %>%
  mutate(Year = "2024-2025")

#MERGING DATA

merged_df <- bind_rows(df_21_22, df_22_23, df_23_24, df_24_25)

#RENAMING THE COLUMN HEADERS IN THE NEW MERGED_DF SHEET

merged_df <- merged_df %>%
  rename(
    "Youth Members of Organized 4-H Community Clubs" = "a",
    "Youth Members of Organized 4-H In-School Clubs" = "b",
    "Youth Members of Organized 4-H After School Clubs" = "c",
    "Youth Members of Military 4-H Clubs" = "d",
    "Total 4-H Club Membership" = "e",
    "Youth Participating in 4-H Special Interest/Short-Term Programs" = "f",
    "Youth Participating in 4-H Overnight Camping Programs" = "g",
    "Youth Participating in 4-H Day Camping Programs" = "h",
    "Total Youth Participating in 4-H Camping Programs" = "i",
    "Youth Participating in School Enrichment Programs" = "j",
    "Youth Participating in Individual Study/Mentoring/Family Learning Programs" = "k",
    "Youth Participating in After-School Programs Using 4-H Curricula/Staff Training" = "l",
    "Youth Participating in Instructional TV/Video/Web Programs" = "m",
    "County Totals" = "total",
    "County" = "CountyArea")

#INSTALLING WRITEXL

install.packages("writexl")

#SAVING MERGED_DF SHEET INTO DOWNLOADS

library(writexl)
write_xlsx(merged_df, "Combined_Participation_Counts.xlsx")

getwd()

#NOW COLOR CODING DATA SECTIONS BY YEAR

#OPENING AND INSTALLING NECESSARY PACKAGES

install.packages("openxlsx")
library(openxlsx)
library(readxl)

#WRITING CODE TO COLOR SPECIFIC ROWS FOR THE YEAR 2021-2022

rows_to_color <- which(grepl("2021|2022"), Combined_Participation_Counts$Year) + 1

color_coded_data <- read.xlsx("Combined_Participation_Counts.xlsx", sheet = "Participation Count")
highlights_by_year_2021_2022 <- createStyle(fgFill = "#FFFF00")

#COMING BACK TO THIS LATER ^^


# ACS DATA ----------------------------------------------------------------

#DOWNLOAD AND INSTALL RELEVANT PACKAGES
install.packages("httr")
library(httr)
install.packages("tidycensus")
library(tidycensus)

#TRANSPLANTING API KEY CODE INTO R, 

census_api_key("b8b3f887b9af8e2d4cd1d9747c7d6319c8a29b45", install = TRUE)

#BEGINNING TO PULL DATA FROM THE CENSUS NOW

#HERE IS AN EXAMPLE OF WHAT USING THE GET_ACS FUNCTION LOOKS LIKE

data <- get_acs(geography = 'county', year = 2019, variables = c('DP04_0134', 'DP03_0062', 'DP03_0009P', 'DP04_0001', 'DP05_0001', 'DP02_0068P'))

#PREVIOUS API KEY WAS EXPIRED, SO I MADE A NEW ONE AND HAVE TO RUN IT AGAIN

census_api_key("b8b3f887b9af8e2d4cd1d9747c7d6319c8a29b45", install = TRUE, overwrite = TRUE)
Sys.getenv("CENSUS_API_KEY")
readRenviron("~/.Renviron")

#NOW, NEW API KEY SHOULD WORK

#RERUNNING THE EXAMPLE GET_ACS FUNCTION

data_example <- get_acs(geography = 'county', year = 2019, variables = c('DP04_0134', 'DP03_0062', 'DP03_0009P', 'DP04_0001', 'DP05_0001', 'DP02_0068P'))

print(data_example)

#EXAMPLE WAS SUCCESSFUL!

#NOW I HAVE TO CONFIGURE IT TO ONLY SHOW STATISTICS FROM VIRGINIA

percent_disability_65_and_over <- get_acs(geography = "county", state = "VA", year = 2021, survey = "acs5", variables = "DP02_0078PE")
print(percent_disability_65_and_over)
load_variables("DP02_0078PE")

#THE CODE IN LINE 207 JUST THREW ERRORS, TRYING SOMETHING NEW

vars <- load_variables(2021, virginia_county_data2021, "acs5", cache = TRUE)
print(vars)

vars %>%
  filter(name == "DP02_0078PE")

#EVERYTHING FROM LINE 211 UNTIL LINE 215 IS A MISTAKE, TRYING AGAIN

library(tidycensus)
library(dplyr)

#RUNNING THE BELOW CODE TO FIND ALL VARIABLES IN THE NATIONWIDE DATABASE

variables <- load_variables(2021, "acs5", cache = TRUE)
print(variables)

#FINDING VARIABLE DESCRIPTION

variables %>%
  filter(name == "DP02_0078PE")

#TROUBLESHOOTING NOW BECAUSE I CAN'T GET THIS TO RUN RIGHT

head(virginia_county_data2021)

head(variables$name, 50)

native_population <- (print(variables %>% 
         filter(grepl("population", label, ignore.case = TRUE))))

#EXAMPLE

variable_population <- (print(variables %>% 
  filter(grepl("population", label, ignore.case = TRUE))))

View(variables)

#THE SOLUTION NOW SHOULD JUST BE TO GET EVERYTHING BY 
#SEARCHING FOR VARIABLES USING THE CODE IN LINES 238 AND 239
#MAKING SURE TO DIFFERENTIATE THEM IN THE ENVIRONMENT AREA BY 
#GIVING A UNIQUE NAME EACH TIME

variable_info <- vars %>% filter(name == "DP02_0078P")
print(variable_info)


# Thursday June 5 ---------------------------------------------------------


library(readxl)
library(dplyr)
library(tidycensus)
library(tidyverse)

#TESTING DIFFERENT VARIABLES TO SEE WHAT HAPPENS
#AS AN EXAMPLE, I RAN CODE TO FIND THE PERCENTAGE OF PEOPLE
#65 AND OVER WHO ARE DISABLED, BUT NOT INSTITUTIONALIZED
#ACROSS ALL VIRGINIA COUNTIES AND INDEPENDENT CITIES
