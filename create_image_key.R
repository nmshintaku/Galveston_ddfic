# Create Image Key

# Read in file names from www folder 

all_images <- list.files("www", full.names = F, pattern = ".jpg")

imagekey <- data.frame(filename = all_images, name = gsub(".jpg", "", all_images))

imagekey$name <- toupper(imagekey$name)
imagekey$name <- lapply(strsplit(imagekey$name, "_"), "[[", 1) |> unlist()

# #life history
# 
# #lh <- read.csv("C:/Users/vforough/Desktop/Database Data/LifeHistory_20250614.csv")
# #lha <- read.csv("C:/Users/vforough/Desktop/Database Data/LifeHistoryAutocalculate_20250624.csv")
# 
# #lha$Last.Seen.Date <- as.Date(lha$Last.Seen.Date)
# 
# #lh$new.Dolphin.Name <-  gsub("'| |\\. ", "", lh$Dolphin.Name)
# 
# #imagekey$id <- lh$Dolphin.ID[match(imagekey$name, lh$new.Dolphin.Name)]
# 
# #check if any names don't match spaces and special characters
# #imagekey[is.na(imagekey$id),]
# 
# imagekey$Birthyear <- lh$Birth.Date[match(imagekey$id, lh$Dolphin.ID)]
# imagekey$Birthyear <- format(as.Date(imagekey$Birthyear), "%Y")
# imagekey$Sex <- lh$Sex[match(imagekey$id, lh$Dolphin.ID)]
# imagekey$Sex <- ifelse(imagekey$Sex=="" | is.na(imagekey$Sex), "UNKNOWN", imagekey$Sex)
# imagekey$lastyear <- lha$Last.Seen.Date[match(imagekey$id, lha$Dolphin.ID)]
# imagekey$lastyear <- as.Date(imagekey$lastyear)
# imagekey$lastyear <- format(imagekey$lastyear, "%Y")
# 
# 
# #location
# finsheet_info <- read.csv("C:/Users/vforough/Desktop/General Shark Bay Coding/Finsheets_mirror/2025 Finsheets/finsheet_df.csv")
# imagekey$location <- finsheet_info$location[match(imagekey$id, finsheet_info$ID)]
# 
# 
# imagekey[is.na(imagekey$location),] #25 need to fix
# 
# #if blank read lastyear and location from oldimagekey
# 
# oldimagekey <- read.csv("oldimagekey.csv")
# 
# imagekey$lastyear <- ifelse(is.na(imagekey$lastyear),
#                             oldimagekey$last_year[match(imagekey$id, oldimagekey$id)],
#                             imagekey$lastyear)
# 
# imagekey$location <- ifelse(is.na(imagekey$location),
#                             oldimagekey$location[match(imagekey$id, oldimagekey$id)],
#                             imagekey$location)
# 
# imagekey$min_birthyear <- lh$Birth.Date.Earliest[match(imagekey$id, lh$Dolphin.ID)]
# imagekey$max_birthyear <- lh$Birth.Date.Latest[match(imagekey$id, lh$Dolphin.ID)]
# imagekey$min_birthyear  <- as.Date(imagekey$min_birthyear)
# imagekey$min_birthyear  <- format(imagekey$min_birthyear, "%Y")
# imagekey$max_birthyear  <- as.Date(imagekey$max_birthyear)
# imagekey$max_birthyear  <- format(imagekey$max_birthyear, "%Y")
# imagekey$min_birthyear <- ifelse(is.na(imagekey$min_birthyear), imagekey$Birthyear, imagekey$min_birthyear)
# imagekey$max_birthyear <- ifelse(is.na(imagekey$max_birthyear), imagekey$Birthyear, imagekey$max_birthyear)
# 
# #pull unknown info
# unknown_info <- read.csv("unknown_info.csv")
# 
# imagekey$location <- gsub("Red Cliff", "Red Cliff Bay", imagekey$location)
# 
# imagekey$location <- ifelse(is.na(imagekey$location),
#                             unknown_info$location[match(imagekey$name, unknown_info$Code)],
#                             imagekey$location)
# 
# imagekey$location <- toupper(imagekey$location)
# 
# imagekey$lastyear <- ifelse(is.na(imagekey$lastyear),
#                             unknown_info$last_year[match(imagekey$name, unknown_info$Code)],
#                             imagekey$lastyear)
# 
# imagekey$demo_status <- ifelse(grepl("^UNK", imagekey$name), "Temporary", "Known")
# 
# dolphin_sample_key <- read.csv("C:/Users/vforough/Desktop/DArT Prep files/dolphin_sample_key2025.csv")
# biopsied <- dolphin_sample_key$Dolphin_ID[which(dolphin_sample_key$Useable == "Yes")]
# 
# imagekey$biopsied <- ifelse(imagekey$id %in% biopsied, "Yes", "No")
# 
# #Remove dead dolphins
# 
# dead_dolphins <- lh$Dolphin.ID[which(lh$Death.Date!="")]
# 
# dolphins_to_move <- paste0("www/", imagekey$filename[which(imagekey$id %in% dead_dolphins)])
# 
# final_destination <- gsub("www", "old", dolphins_to_move)
# 
# file.rename(dolphins_to_move, final_destination)
# 
# imagekey <- imagekey[-which(imagekey$id %in% dead_dolphins),]
# 
# #Check missing location and last sighting year again
# imagekey[is.na(imagekey$location) | is.na(imagekey$lastyear),] #34 need to fix
# 
# 
# 
# #Update last sighting dates



write.csv(imagekey, "imagekey.csv", row.names = FALSE)
