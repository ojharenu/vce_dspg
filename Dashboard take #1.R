# === LIBRARIES ===
library(shiny)
library(shinyWidgets)
library(bslib)
library(dplyr)
library(readr)
library(leaflet)
library(sf)
library(tigris)
library(tidycensus)

options(tigris_use_cache = TRUE)

# === UI ===
ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  
  tags$head(
    tags$style(HTML("
      h1, h2, h3, h4 {
        color: #2e7d32;
        font-weight: bold;
      }
    "))
  ),
  
  h1("Volunteer Data Dashboard"),
  
  tabsetPanel(
    tabPanel("Volunteer County Data",
             h3("County Data"),
             p("Monitor the county data for volunteers"),
             
             leafletOutput("volunteer_map", height = "600px"),
             textOutput("error")
    ),
    
    tabPanel("4-H Data",
             p("More tables to come!!")
    )
  )
)

# === SERVER ===
server <- function(input, output, session) {
  tryCatch({
    # Set Census API Key
    census_api_key("6ee5ecd73ef70e9464ee5509dec0cdd4a3fa86c7", install = TRUE, overwrite = TRUE)
    
    # Clean volunteer data
    volunteer_data <- read.csv("countiesimpact.csv") %>%
      filter(Hours != "did not log hours") %>%
      mutate(
        County = tolower(County),
        County = gsub(" county", "", County),
        County = gsub(" city", "", County),
        County = trimws(County)
      ) %>%
      group_by(County) %>%
      summarise(Volunteers = n(), .groups = "drop")
    
    # Load VA counties
    va_counties <- counties(state = "VA", cb = TRUE, year = 2023) %>%
      st_transform(crs = 4326) %>%
      mutate(
        County = tolower(NAME),
        County = gsub(" county", "", County),
        County = trimws(County)
      )
    
    # Load population data with correct naming and Fairfax fix
    va_population <- get_acs(
      geography = "county",
      state = "VA",
      variables = "B01003_001",
      year = 2023,
      survey = "acs5",
      output = "wide"
    ) %>%
      mutate(
        County = tolower(NAME),
        County = gsub(" county, virginia", "", County),
        County = gsub(" city, virginia", "", County),
        County = trimws(County),
        Population = B01003_001E
      ) %>%
      # Manually fix Fairfax County population
      mutate(
        Population = ifelse(County == "fairfax", 1147532, Population),
        Population = ifelse(County == "franklin", 54477, Population)
      ) %>%
      select(County, Population)
    
    # Merge data
    combined_data <- left_join(volunteer_data, va_population, by = "County") %>%
      mutate(
        VolunteerRate = round((Volunteers / Population) * 100, 2)
      )
    
    map_data <- left_join(va_counties, combined_data, by = "County") %>%
      st_as_sf()
    
    # Safe color scale
    max_rate <- max(map_data$VolunteerRate, na.rm = TRUE)
    if (!is.finite(max_rate)) max_rate <- 1
    max_rate <- ceiling(max_rate * 4) / 4
    breaks <- seq(0, max_rate, by = 0.25)
    
    pal <- colorBin("YlGnBu", domain = map_data$VolunteerRate, bins = breaks, na.color = "#f0f0f0")
    
    # Labels
    map_data <- map_data %>%
      mutate(label_content = paste0(
        "<strong>", toupper(County), "</strong><br>",
        "Volunteers: ", ifelse(is.na(Volunteers), "N/A", Volunteers), "<br>",
        "Population: ", ifelse(is.na(Population), "N/A", Population), "<br>",
        "Volunteer Rate: ", ifelse(is.na(VolunteerRate), "N/A", paste0(VolunteerRate, "%"))
      ))
    
    # Map
    output$volunteer_map <- renderLeaflet({
      leaflet(map_data) %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(
          fillColor = ~pal(VolunteerRate),
          color = "black",
          weight = 1,
          fillOpacity = 0.7,
          label = lapply(map_data$label_content, htmltools::HTML),
          highlightOptions = highlightOptions(
            weight = 2,
            color = "#666",
            fillOpacity = 0.9,
            bringToFront = TRUE
          )
        ) %>%
        addLegend("bottomright",
                  pal = pal,
                  values = map_data$VolunteerRate,
                  title = "Volunteers as % of Population",
                  opacity = 1
        ) %>%
        setView(lng = -78.6569, lat = 37.4316, zoom = 6)
    })
    
    # Debug info
    output$debug <- renderPrint({
      list(
        n_counties = nrow(map_data),
        counties_with_data = sum(!is.na(map_data$VolunteerRate)),
        total_volunteers = sum(map_data$Volunteers, na.rm = TRUE),
        avg_rate = mean(map_data$VolunteerRate, na.rm = TRUE)
      )
    })
    
  }, error = function(e) {
    output$error <- renderText({
      paste("Error loading data:", e$message)
    })
  })
}

# === RUN ===
shinyApp(ui = ui, server = server)

