P5 <- function() {
  message("Subsetting data...")
  data <- ddply(NEI, .(year), summarize, Emissions = sum(Emissions[fips=="24510" & type=="ON-ROAD"]))
  data$Emissions <- lapply(data$Emissions, function(x) round(x, 2))
  message("Done.\n")
  
  message("Plotting total emissions by year...")
  
  png("png/P5.png", 600, 400)
  
  par(mar = c(5, 5, 3, 1))
  with(data, plot(year, Emissions, pch = 20, xlim=c(1998, 2009), xaxt="n",
                  col="steelblue", main = expression("US Annual PM"[2.5] * " Emissions - Motor Vehicles, Baltimore City"), 
                  xlab = "Year", ylab = expression("PM"[2.5] * " Emissions (tons)")))
  
  lines(data$year, data$Emissions, type = "l", lwd = 2, col="steelblue")
  axis(1, c(1999, 2002, 2005, 2008))
  
  dev.off()
  
  message("Done. File written to png/P5.png\n")
}

P5()
rm(P5)