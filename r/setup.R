setup <- function() {
  message("Checking/Creating required directories...")
  if (!file.exists("png")) dir.create("png")
  if (!file.exists("data")) dir.create("data")
  message("Done.\n")
  
  message("Checking/Downloading/Unzipping data...")
  if (!file.exists("data/summarySCC_PM25.rds") || !file.exists("data/Source_Classification_Code.rds")) {
    if (!file.exists("data/pm25.zip")) download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data/pm25.zip")
    unzip("data/pm25.zip", exdir="data")
  }
  message("Done.\n")
  
  message("Loading data into the global environment... (this may take a while)")
  if (!exists("NEI")) assign("NEI", readRDS("data/summarySCC_PM25.rds"), .GlobalEnv) else message("An NEI variable already exists. Skipping.")
  if (!exists("SCC")) assign("SCC", readRDS("data/Source_Classification_Code.rds"), .GlobalEnv) else message("An SCC variable already exists. Skipping.")
  message("Done.\n")
  
  message("Installing/Loading required libraries...")
  require("ggplot2")
  require("plyr")
  message("Done.\n")
  
  message("Setup complete.\n")
}

setup()
rm(setup)