P6 <- function() {
  message("Subsetting data...")
  d.baltimore <- ddply(subset(NEI, fips == '24510' & type == 'ON-ROAD'), .(year), summarize, Emissions = round(sum(Emissions), 2))
  d.losangeles <- ddply(subset(NEI, fips == '06037' & type == 'ON-ROAD'), .(year), summarize, Emissions = round(sum(Emissions), 2))
  d.both <- ddply(subset(NEI, (fips == '24510' | fips == '06037') & type == 'ON-ROAD'), .(year, fips), summarize, Emissions = round(sum(Emissions), 2))
  
  message("Done.\n")
  
  message("Plotting total emissions by year...")
  
  png("png/P6.png", 800, 600)
  
  g <- ggplot(d.both, aes(year, Emissions))
  g <- g + 
    geom_point(data = d.losangeles, aes(color = "Los Angeles"), pch = 19) +
    geom_point(data = d.baltimore, aes(color = "Baltimore"), pch = 19) +
    geom_line(data = d.losangeles, aes(color = "Los Angeles"), lwd = 1) +
    geom_line(data = d.baltimore, aes(color = "Baltimore"), lwd = 1) +
    scale_color_manual(values = c("orchid","steelblue")) +
    
    theme(strip.text.y = element_text(size = 14), plot.margin = unit(c(1, 1, 1, 1), 'cm')) +
    theme(plot.title = element_text(hjust=0.5, size = 15)) +
    xlab("Year") + ylab("Emissions (tons)") + labs(color="Counties") +
    
    ggtitle(expression("US Annual PM"[2.5] * " Emissions - Motor Vehicles")) +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))
  
  plot(g)
  
  dev.off()
  
  message("Done. File written to png/P6.png\n")
}

P6()
rm(P6)