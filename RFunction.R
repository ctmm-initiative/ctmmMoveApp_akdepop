library(ctmm)

rFunction = function(data) {
  
  pdf(appArtifactPath("akdepop.pdf"))
  res <- meta(data)
  dev.off()
  
  capture.output(res, file = appArtifactPath("akdepop_summary.txt"))
  
  return(data)
  
}