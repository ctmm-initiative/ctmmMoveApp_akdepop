library(ctmm)

rFunction = function(data) {
  
  pdf(appArtifactPath("akdepop_summary.pdf"))
  meta <- ctmm::meta(data[[2]], plot = TRUE)
  dev.off()
  
  # pop means
  MEAN <- mean(data[[2]]) # distribution of the sample
  PKDE <- pkde(data[[3]], data[[2]]) # distribution of the population
  
  EXT <- extent(list(MEAN, PKDE))
  COL <- c("red", "black", "blue")
  
  pdf(appArtifactPath("dist_of_sample_and_pop.pdf"))
  par(mfrow = c(1,2))
  plot(data[[3]], MEAN, col = COL, ext = EXT)
  title("Distribution of the sample")
  plot(data[[3]], PKDE, col = COL, ext = EXT)
  title("Distribution of the population")
  par(mfrow = c(1,1))
  dev.off()
  
  s <- rbind(
    meta[1, , drop = FALSE], 
    summary(MEAN)$CI[1, , drop = FALSE], 
    summary(PKDE)$CI[1, , drop = FALSE]) 
  s1 <- as.data.frame(s, row.names = FALSE)
  s1[, "units"] <- row.names(s)
  write.csv(s1, appArtifactPath("akdepop_summary.csv"), row.names = FALSE)
  
  sf::st_as_sf(ctmm::SpatialPolygonsDataFrame.UD(MEAN, level.UD = 0.95)) |> 
    sf::st_write(appArtifactPath("dist_sample.gpkg"), append = FALSE)
  
  sf::st_as_sf(ctmm::SpatialPolygonsDataFrame.UD(PKDE, level.UD = 0.95)) |> 
    sf::st_write(appArtifactPath("dist_pop.gpkg"), append = FALSE) 
  
  writeRaster(MEAN, appArtifactPath("dist_sample.tif"), overwrite = TRUE)
  writeRaster(PKDE, appArtifactPath("dist_pop.tif"), overwrite = TRUE)
  
  return(data)
  
}