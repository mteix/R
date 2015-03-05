library(caTools)         # external package providing write.gif function

rm(list=ls())

jet.colors <- colorRampPalette(gray(50:0 / 50)) #50 shades of grey

#jet.colors <- colorRampPalette(rainbow(10))

#Time measured

#ptm <- proc.time()
#proc.time() - ptm

startTime <- Sys.time()


iter <- 100
m <- 50 # define size


#define 0 1 matrix

# cluster size

#initialize random Matrix

#sqNet <- matrix(sample((0:1),size=m*m,replace=T),m,m)
#initiate matrix with some squares

sqNet <- matrix(as.integer(abs(rnorm(m*m)*10) %% 2),m,m)

# the Life is the matrix to be printed. SqNet is the one that the
# adjancencies are evaluates

theLife <- sqNet

X <- array(0, c(m,m,iter)) # initialize output 3D array

k=1
X[,,k] <- theLife
write.gif(X, "Life.gif",col=jet.colors, delay=10)

for (k in 2:iter) {        
  
  cat ("Iterations Completed: ", k/iter*100, "% ")
  
  #######################################
  #Statting the cell automato loop
  # iant, jant etc are periodic boundaries
  # in the m x m lattice
  #######################################
 
  for(i in 1:m){
    iant <- i-1
    ipos <- i+1
    if(i-1<1) iant <- m
    if(i+1>m) ipos <- 1
    for(j in 1:m){  
      
      jant=j-1
      jpos=j+1
      if(j-1<1) jant <- m 
      if(j+1>m) jpos <- 1
      
      #count the number of neighbour of the cell
      
      neigh <- sqNet[iant,j]+sqNet[ipos,j]+sqNet[i,jant]+sqNet[i,jpos] #neighbours 1st order
      neigh <- neigh + sqNet[iant,jant]+sqNet[iant,jpos]+sqNet[ipos,jant]+sqNet[ipos,jpos]
      
      
      ##########################################################
      ##########################################################
      #These rules are from the "Game of Life" celullar automato
      # (Conway, 1970)
      ##########################################################
      ##########################################################
      
      if(sqNet[i,j]==1){
        
        #DEAD BY OVER AND UNDER CROWD
        if(neigh<2 || neigh>3) {
          theLife[i,j] <- 0
        }
        else{
          theLife[i,j] <- 1
        }
        
      }
        
      
      if(sqNet[i,j]==0){
        if(neigh == 3) {
          theLife[i,j] <- 1
        }
        else{
          theLife[i,j] <- 0
        }
      }
    
      #END OF RULES
      
    }
    
   }
  cat("...........Difference: ", sum(theLife)-sum(sqNet),"\n")
  
  
  X[,,k] <- theLife # capture results
  
  ######################################
  # exit condition when life stabilizes
  ######################################
  
  
  #if(abs((sum(theLife)-sum(sqNet))/(m*m)) <= 1/10000) {
  #  write.gif(X, "Life.gif",col=jet.colors, delay=50)
  #  break
  #}
  
  #######################################
  
  sqNet <- theLife
}


cat("\n\n Elapased program time (m): ",(Sys.time()-startTime)/60)

startTime <- Sys.time()
write.gif(X, "Life.gif",col=jet.colors, delay=50)

cat("\n\n Writing gif  time (s): ",Sys.time()-startTime)

