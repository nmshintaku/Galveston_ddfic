library(shiny)

# get filepaths for all images in the wwww folder
all_images <- list.files("www", full.names = F, pattern = ".png|.jpg")
image_key <- read.csv("imagekey.csv")
image_key <- image_key[!duplicated(image_key$name), ]

# confirm key and images match
my_images <- image_key[which(image_key$filename %in% all_images), ]

source("ui.R")

# Server
server <- function(input, output, session) {
  # Paste the image grid HTML into Shiny
  output$myGrid <- renderUI({
    # Select images
    {
      if (length(input$sex) < 3) {
        my_images <- my_images[which(my_images$Sex %in% input$sex), ]
      }
      
      if (input$last_year < 2025) {
        my_images <- my_images[which(my_images$lastyear <= input$last_year), ]
      }
      
      if (length(input$location) < length(location_choices)) {
        my_images <- my_images[which(my_images$location %in% toupper(input$location)), ]
      }
      
      if (length(input$biopsied) < length(biopsy_choices)) {
        my_images <- my_images[which(my_images$biopsied %in% input$biopsied), ]
      }
      if (length(input$demo) < length(demo_choices)) {
        my_images <- my_images[which(my_images$demo_status %in% input$demo), ]
      }
      
      if (input$min_birthyear > 1955) {
        my_images <- my_images[which(my_images$min_birthyear >= input$min_birthyear), ]
      }
      
      if (input$max_birthyear < 2025) {
        my_images <- my_images[which(my_images$max_birthyear <= input$max_birthyear), ]
      }
      
    }
    
    # Calculate the number of images per column (3 in total)
    nImages <- nrow(my_images)
    perCol <- rep(floor(nImages / 3), 3)
    if (nImages %% 3 > 0) {
      perCol[1:(nImages %% 3)] <- perCol[1:(nImages %% 3)] + 1
    }
    perCol <- cumsum(c(1, perCol))
    
    # Create the HTML for the image grid
    imageGrid <- paste(
      "<div class='row'>",
      paste(purrr::map(1:3, function(i) {
        paste("<div class='column'>",
              paste0("<img src='",
                     my_images[perCol[i]:(perCol[i + 1] - 1), "filename"], "' style='width:100%'></a><p>",
                     my_images[perCol[i]:(perCol[i + 1] - 1), "name"], " ",
                     my_images[perCol[i]:(perCol[i + 1] - 1), "last_year"], "</p>",
                     collapse = ""
              ),
              "</div>",
              collapse = ""
        )
      }), collapse = ""),
      "</div>"
    )
    
    # If no images selected
    if (nImages == 0) {
      imageGrid <- HTML(paste0("<div class=", "header", "><h1>No images selected</h1>
                     </div>"))
    }
    
    # HTML for plotting
    HTML(imageGrid)
  })
  
  
  # Clear selections
  observeEvent(input$clear, {
    updateSelectInput(session, "sex",
                      selected = c("MALE", "FEMALE", "UNKNOWN")
    )
    updateSelectInput(session, "last_year",
                      selected = 2025
    )
    updateSelectInput(session, "location",
                      selected = location_choices
    )
    updateSelectInput(session, "biopsied",
                      selected = biopsy_choices
    )
    updateSelectInput(session, "demo",
                      selected = demo_choices
    )
    updateSelectInput(session, "min_birthyear",
                      selected = 1955
    )
    updateSelectInput(session, "max_birthyear",
                      selected = 2025
    )
    updateCheckboxInput(session, "all", value = T)
  })
  
  observeEvent(input$all, {
    outcome <- if(input$all){location_choices}else{""}
    updateSelectInput(session, "location",
                      selected =  outcome
                      
    )
  })
  
}

# Run app
shinyApp(ui, server)