P3 <- function() {
  message("Subsetting data...")
  d.baltimore <- subset(NEI, fips=="24510")
  data <- ddply(d.baltimore, .(year,type), summarize, Emissions = sum(Emissions))
  message("Done.\n")
  
  message("Plotting total emissions by year...")
  
  png("png/P3.png", width = 800, height = 800)
  
  g <- ggplot(data, aes(year, Emissions)) + facet_grid(type ~ ., scale = 'free') +
    
    # only allowing the scales to be free because some of the graphs look like straight lines on a fixed scale
    
    geom_line(col = 'steelblue', lwd = 1) + geom_point(col = 'steelblue') +
    theme(strip.text.y = element_text(size = 12)) + theme(plot.title = element_text(hjust=0.5, size = 15)) +
    
    xlab("Year") + ylab("Emissions (tons)") + theme(axis.title.y = element_text(angle = 90)) +
    theme(axis.title.x = element_text(angle = 00)) +
    
    ggtitle(expression("US Annual PM"[2.5] * " Emissions - Baltimore City")) + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

  plot(g)
  dev.off()
  
  message("Done. File written to png/P3.png\n")
}

P3()
rm(P3)