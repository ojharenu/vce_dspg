setwd("/Users/diegocuadra/Downloads")
list.files()



# Load the existing sheets 
df_21_22 <- read_excel("Ethnicity Count(21-22).xlsx", sheet = "Ethnicity Count") %>%
  +     mutate(Year = "2021-2022")
                                                                            
df_22_23 <- read_excel("Ethnicity Count (22-23).xlsx", sheet = "Ethnicity Count") %>%
  +     mutate(Year = "2022-2023")
                                                                            
# Add the new files
df_23_24 <- read_excel("Ethnicity Count (23-24).xlsx", sheet = "Ethnicity Count") %>%
  +     mutate(Year = "2023-2024")
                                                                             
df_24_25 <- read_excel("Ethnicity Count (24-25 through June 2).xlsx", sheet = "Ethnicity Count") %>%
  +     mutate(Year = "2024-2025")
                                                                              
 # Combine all four into one data frame
combined_df <- bind_rows(df_21_22, df_22_23, df_23_24, df_24_25)
# View the combined result
View(combined_df) 
