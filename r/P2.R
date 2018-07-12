P2 <- function() {
  message("Subsetting data...")
  data <- ddply(NEI, .(year), summarize, Emissions = sum(Emissions[fips=="24510"]))
  data$Emissions <- lapply(data$Emissions, function(x) round(x / 1e3, 2))
  message("Done.\n")
  
  message("Plotting total emissions by year...")
  
  png("png/P2.png", 600, 400)
  
  par(mar = c(5, 5, 3, 1))
  with(data, plot(year, Emissions, pch = 20, xlim=c(1998, 2009), xaxt="n",
                  col="steelblue", main = expression("US Annual PM"[2.5] * " Emissions - Baltimore City"), 
                  xlab = "Year", ylab = expression("PM"[2.5] * " Emissions (thousands of tons)")))
  
  lines(data$year, data$Emissions, type = "l", lwd = 2, col="steelblue")
  axis(1, c(1999, 2002, 2005, 2008))
  
  dev.off()
  
  message("Done. File written to png/P2.png\n")
}

P2()
rm(P2)