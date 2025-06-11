library(tidycensus) 
census_api_key("6ee5ecd73ef70e9464ee5509dec0cdd4a3fa86c7", install = TRUE)
get_acs(geography = "county", 
        state = "VA", 
        variables = "B19013_001", 
        year = 2022, 
        survey = "acs5")
v21 <- load_variables(2021, "acs5", cache = TRUE)
View(v21)
get_acs(geography = "county", 
        +         state = "VA", 
        +         variables = "DP02PR_0001", 
        +         year = 2022, 
        +         survey = "acs5")
v2019 <- load_variables(2019, "acs5/profile", cache = TRUE)
View(v2019)
install.packages("tidycensus")
install.packages("dplyr")
install.packages("readxl")


library(tidycensus)
library(readxl)
library(dplyr)
Hispanic_Population <- get_acs(geography = "county", state = "VA", year = 2021, survey = "acs5", variables = "DP02_0078PE")
print(virginia_county_data2021)
variables <- load_variables(2021, "acs5", cache = TRUE)
print(variables)
 native_population <- (print(variables %>% 
         filter(grepl("population", label, ignore.case = TRUE))))
 income_data <- get_acs(
   geography = "county",
   state = "VA",
   year = 2021,
   survey = "acs5",
   variables = "B03002_003"
 )
 # Define variables for Hispanic kids by age and sex
 hispanic_kid_vars <- c(
   "B01001I_004", "B01001I_005", "B01001I_006", "B01001I_007",  # Male under 18
   "B01001I_018", "B01001I_019", "B01001I_020", "B01001I_021"   # Female under 18
 )
 
 # Get data for all counties in Virginia
 hispanic_kids <- get_acs(
   geography = "county",
   state = "VA",
   year = 2021,
   survey = "acs5",
   variables = hispanic_kid_vars,
   summary_var = "B01001I_001"
 )
 
 # Sum total Hispanic children per county
 hispanic_kid_summary <- hispanic_kids %>%
   group_by(NAME) %>%
   summarize(total_hispanic_kids = sum(estimate))
 
 print(hispanic_kid_summary)
 library(tidycensus)
 library(dplyr)
 
 # Define variable codes for Hispanic children ages 5–19
 hispanic_youth_vars <- c(
   "B01001I_005", "B01001I_006", "B01001I_007", "B01001I_008",  # Males
   "B01001I_019", "B01001I_020", "B01001I_021", "B01001I_022"   # Females
 )
 
 # Get data for Virginia counties for 2021
 hispanic_youth_data <- get_acs(
   geography = "county",
   state = "VA",
   year = 2021,
   survey = "acs5",
   variables = hispanic_youth_vars
 )
 
 # Sum up the estimates by county
 hispanic_youth_summary <- hispanic_youth_data %>%
   group_by(NAME) %>%
   summarize(total_hispanic_youth_5_19 = sum(estimate))
 
 # View the result
 print(hispanic_youth_summary)
 hispanic_youth_vars <- c(
   "B01001I_005", "B01001I_006", "B01001I_007", "B01001I_008",  # Male 5–19
   "B01001I_019", "B01001I_020", "B01001I_021", "B01001I_022"   # Female 5–19
 )
 
 # Get ACS data for 2021 by county in Virginia
 hispanic_youth_data <- get_acs(
   geography = "county",
   state = "VA",
   year = 2021,
   survey = "acs5",
   variables = hispanic_youth_vars
 )
 
 # Summarize total Hispanic youth (ages 5–19) per county
 hispanic_youth_summary <- hispanic_youth_data %>%
   group_by(NAME) %>%
   summarize(total_hispanic_youth_5_19 = sum(estimate))
 
 # Export to Excel file
 write_xlsx(hispanic_youth_summary, "hispanic_youth_virginia_2021.xlsx")
 
 library(tidycensus)
 library(dplyr)
 library(writexl)
 hispanic_youth_vars <- c(
   "B01001I_005", "B01001I_006", "B01001I_007", "B01001I_008",  # Male 5–19
   "B01001I_019", "B01001I_020", "B01001I_021", "B01001I_022"   # Female 5–19
 )
 
 # Get ACS data for 2021 by county in Virginia
 hispanic_youth_data <- get_acs(
   geography = "county",
   state = "VA",
   year = 2021,
   survey = "acs5",
   variables = hispanic_youth_vars
 )
 
 # Summarize total Hispanic youth (ages 5–19) per county
 hispanic_youth_summary <- hispanic_youth_data %>%
   group_by(NAME) %>%
   summarize(total_hispanic_youth_5_19 = sum(estimate))
 
 # Export to Excel file
 write_xlsx(hispanic_youth_summary, "hispanic_youth_virginia_2021.xlsx")
 
 
 ##Merging Hispics Data
 library(readxl)
 library(dplyr)
 library(writexl)
 
 # Read both sheets
 df_4h <- read_excel("Hispanics_in_4H.xlsx")
 df_total <- read_excel("hispanic_youth_virginia_2021.xlsx")
 
 # Standardize column names
 colnames(df_4h) <- c("County", "Hispanics_in_4H")
 colnames(df_total) <- c("County", "Total_Hispanic_Youth_5_19")
 
 # Clean up county names
 df_4h$County <- trimws(df_4h$County)
 df_total$County <- trimws(df_total$County)
 
 # Filter df_total to only counties that appear in df_4h
 df_total_filtered <- df_total %>% filter(County %in% df_4h$County)
 
 # Merge datasets
 merged_df <- left_join(df_4h, df_total_filtered, by = "County")
 
 # Calculate participation percentage
 merged_df <- merged_df %>%
   mutate(Participation_Percentage = round((Hispanics_in_4H / Total_Hispanic_Youth_5_19) * 100, 2))
 
 # Export to Excel
 write_xlsx(merged_df, "merged_hispanic_participation_data.xlsx")
 
 getwd()
 setwd("/Users/diegocuadra/Downloads") 
 
 ##Merging Hispics Data
 library(readxl)
 library(dplyr)
 library(writexl)
 
 # Read both sheets
 df_4h <- read_excel("Hispanics_in_4H.xlsx")
 df_total <- read_excel("hispanic_youth_virginia_2021.xlsx")
 
 # Standardize column names
 colnames(df_4h) <- c("County", "Hispanics_in_4H")
 colnames(df_total) <- c("County", "Total_Hispanic_Youth_5_19")
 
 # Clean up county names
 df_4h$County <- trimws(df_4h$County)
 df_total$County <- trimws(df_total$County)
 
 # Filter df_total to only counties that appear in df_4h
 df_total_filtered <- df_total %>% filter(County %in% df_4h$County)
 
 # Merge datasets
 merged_df <- merge(df_4h, df_total, by = "County")
 
 # Calculate participation percentage
 merged_df <- merged_df %>%
   mutate(Participation_Percentage = round((Hispanics_in_4H / Total_Hispanic_Youth_5_19) * 100, 2))
 
 # Export to Excel
 write_xlsx(merged_df, "merged_hispanic_participation_data.xlsx")
