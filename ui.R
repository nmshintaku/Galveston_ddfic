
# UI

location_choices <- c(
  "Galveston Ship Channel",
  "Bolivar",
  "North Galveston")

biopsy_choices <- c(
  "Yes",
  "No",
  "Wait"
)

demo_choices <- c(
  "Known",
  "Temporary",
  "Unknown"
)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      br(),
      actionButton("clear", "clear"),
      br(),
      br(),
      selectInput("sex",
                  "Select the sex of the animals",
                  choices = c("MALE", "FEMALE", "UNKNOWN"),
                  multiple = T, 
                  selected = c("MALE", "FEMALE", "UNKNOWN")
      ),
      br(),
      selectInput("last_year",
                  "Select the maximum year of last sighting",
                  choices = c(2025:1999),
                  multiple = F, 
                  selected = 2025,
      ),
      br(),
      checkboxInput("all", "All Locations", value = T), 
      selectInput("location",
                  "Select the locations",
                  choices = location_choices,
                  selected = location_choices,
                  multiple = T,
      ),
      br(),selectInput("min_birthyear",
                       "Select the earliest year of birth",
                       choices = c(1955:2025),
                       multiple = F, 
                       selected = 1955,
      ),
      br(),
      selectInput("max_birthyear",
                  "Select the latest year of birth",
                  choices = c(2025:1955),
                  multiple = F, 
                  selected = 2025,
      ),
      br(),
      # checkboxInput("allb", "All Statuses", value = T), 
      selectInput("biopsied",
                  "Select biopsied status",
                  choices = biopsy_choices,
                  selected = biopsy_choices,
                  multiple = T,
      ),
      br(),
      # checkboxInput("alld", "All Statuses", value = T), 
      selectInput("demo",
                  "Select demographic status",
                  choices = demo_choices,
                  selected = demo_choices,
                  multiple = T,
      ),
      br(),
      width = 3
    ),
    mainPanel(
      # CSS
      tags$head(
        tags$style(HTML("<style>
                          * {
                            box-sizing: border-box;
                          }

                        body {
                          margin: 0;
                          font-family: Arial;
                        }

                        .header {
                          text-align: center;
                          padding: 32px;
                        }

                        .row {
                          display: -ms-flexbox;
                            display: flex;
                          -ms-flex-wrap: wrap;
                            flex-wrap: wrap;
                          padding: 0 4px;
                        }
                          .column {
                            -ms-flex: 33%;
                              flex: 33%;
                            max-width: 33%;
                            padding: 0 4px;
                          }

                        .column img {
                          margin-top: 8px;
                          vertical-align: middle;
                          width: 100%;
                          aspect-ratio: 1 / 1;
                          object-fit: cover;
                        }
                        </style>"))),
      
      uiOutput("myGrid"),
      
      width = 9
    )
  )
)
