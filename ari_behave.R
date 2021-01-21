# ari behavior
library(aricode)

ari_behave <- function(cl=NULL, n=100, noise=0.1, n_repeat=1, balanced=FALSE) {
  stopifnot(all(noise >= 0 & noise <= 1))
  
  if(length(noise)==2) balanced <- TRUE
  if(balanced && length(noise)==1) noise <- c(noise, noise)
  
  if(is.null(cl)) {
    n0 <- round(n/2)
    n1 <- n - n0
    cl <- c(rep(0, n0), rep(1, n1))
  }
  i0 <- which(cl==0)
  i1 <- which(cl==1)
  a <- rep(NA, n_repeat)
  for(r in 1:n_repeat) {
    if(balanced) {
      ir0 <- sample(i0, round(noise[1]*length(i0)), replace = FALSE)
      ir1 <- sample(i1, round(noise[2]*length(i1)), replace = FALSE)
      ir <- c(ir0, ir1)
    } else {
      stopifnot(length(noise)==1)
      ir <- sample(1:n, round(noise*n), replace = FALSE)
    }
    clr <- cl
    clr[ir] <- 1 - clr[ir]
    a[r] <- ARI(cl, clr)
  }
  return(a)
}

run_ari_behave <- function(cl=NULL, n=100, noises=seq(0, 0.5, 0.05), n_repeat=1, cl_balance=c(0.5), balanced=FALSE) {
  a <- matrix(NA, ncol=length(noises), nrow=length(cl_balance))
  colnames(a) <- noises
  rownames(a) <- cl_balance
  
  legtxt <- c()
  for(ci in 1:length(cl_balance)) {
    mycl <- cl
    if(is.null(mycl)) {
      stopifnot(cl_balance[ci] > 0 && cl_balance[ci] < 1)
      n0 <- round(n*cl_balance[ci])
      n1 <- n - n0
      mycl <- c(rep(0, n0), rep(1, n1))
    }
  
    for(ni in 1:length(noises)) {
      aa <- ari_behave(noise=noises[ni], cl=mycl, n=n, n_repeat=n_repeat, balanced=balanced)
      a[ci, ni] <- mean(aa)
    }
    
    if(ci==1) {
      plot(noises, a[ci,], xlab = "noise", ylab = "ari", pch=16, type="b")
    } else {
      points(noises, a[ci,], pch=16, type="b", col=ci)
    }
    legtxt <- c(legtxt, paste("cl0 prop:", cl_balance[ci]))
  }
  
  points(x=c(min(noises), max(noises)), y=c(1, 0), type="l", lty=2, col="gray")
  abline(h=0, lty=3, col="gray")
  legend("topright", legend=legtxt, col=1:length(legtxt), pch=16)
  return(a)
}