library(ctmm)

rFunction = function(data) {
  
  pdf(appArtifactPath("akdepop.pdf"))
  res <- meta(data[[2]])
  dev.off()
  
  capture.output(res, file = appArtifactPath("akdepop_summary.txt"))
  
  return(data)
  
}