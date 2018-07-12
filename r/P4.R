P4 <- function() {
  message("Subsetting data...")
  d.coal <- ddply(NEI, .(year, SCC), summarize, Emissions = sum(Emissions))
  SCC <- SCC[, c('SCC', 'EI.Sector')]
  
  ei.lower <- tolower(SCC$EI.Sector)
  scc_subset <- subset(SCC, grepl('fuel comb - [a-z ,/]* - coal', ei.lower))
  
  d.coal <- subset(d.coal, d.coal$SCC %in% scc_subset$SCC)
  d.coal <- ddply(d.coal, .(year), summarize, Emissions = sum(Emissions))
  d.coal$Emissions <- lapply(d.coal$Emissions, function(x) round(x / 1e3, 2))
  
  message("Done.\n")
  
  message("Plotting total emissions by year...")
  
  png("png/P4.png", width = 800, height = 800)
  
  par(mar=c(5,5,3,1))
  with(d.coal, plot(year, Emissions, pch = 19, xlim = c(1998, 2009), xaxt="n", col="steelblue",
                      main = expression("US Annual PM"[2.5] * " Emissions - Coal Combustion & Similar Sources"),
                      xlab = "Year", ylab = expression("Emissions (thousands of tons)")))
  
  lines(d.coal$year, d.coal$Emissions, type = "l", lwd = 2, col="steelblue")
  axis(1, c(1999, 2002, 2005, 2008))
  dev.off()
  
  message("Done. File written to png/P4.png\n")
}

P4()
rm(P4)