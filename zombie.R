#
#This will be the zommbie code
#
library(caTools)         # external package providing write.gif function

rm(list=ls())

jet.colors <- colorRampPalette(c("black","red","blue"))

#Time measured

#ptm <- proc.time()
#proc.time() - ptm

startTime <- Sys.time()
iter <- 500
m <- 100 # define size



# Initialization ----------------------------------------------------------

#initialize random Matrix

#sqNet <- matrix(sample((0:1),size=m*m,replace=T),m,m)
#initiate matrix with some squares

#a matrix full of humans, zombies and empty spaces
sqNet <- matrix(as.integer(abs(rnorm(m*m)*10) %% 3),m,m)


# #rbinom can generate more humans. Prob states how much of humans
# # we want
# probHum = 0.5
# sqNet <- matrix(rbinom(m*m,1,probHum),m,m)
# sqNet <- sqNet + matrix(rbinom(m*m,1,probHum),m,m)

# the Life is the matrix to be printed. SqNet is the one that the
# adjancencies are evaluates

theLife <- sqNet

X <- array(0, c(m,m,iter)) # initialize output 3D array



# AUTOMATA + ZOMBIE RULES -------------------------------------------------


for (k in 1:iter) {        
  
  cat ("Iterations Completed: ", k/iter*100, "% ")
  
  #######################################
  # Starting the cell automato loop
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
      
      neigh <- c(sqNet[iant,j] ,sqNet[ipos,j], sqNet[i,jant], sqNet[i,jpos])
      
      #comment next line for only 4 neighbours
      neigh <- c(neigh,sqNet[iant,jant],sqNet[iant,jpos],sqNet[ipos,jant],sqNet[ipos,jpos])
      
      #counting species
      
      humanCnt = length(neigh[neigh==2])
      zombieCnt = length(neigh[neigh==1])
      
      ##########################################################
      ##########################################################
      # Representation in zombie game
      # Human = 2; Zombie = 1 ; Dead = 0
      # (adapted from Game of Life)
      ##########################################################
      ##########################################################
      
      # Human Rules -------------------------------------------------------------  
      
      #condition that humans die by overcrowding (>4 human neighbours) 
      if(sqNet[i,j]==2 && (humanCnt>3 || humanCnt <2)){
          theLife[i,j] <- 0
      }
      
      #A human is born in an empty space and with 
      #humans guarding
      
      if(sqNet[i,j]==0 && humanCnt==3){
        theLife[i,j] <- 2 
      }
      
      # Zombies rules -----------------------------------------------------------
      
      if( k %% 3 == 0){
        #zombies also die by overcrowding 
        if(sqNet[i,j]==1 && (zombieCnt>3 || zombieCnt<2)){
          theLife[i,j] <- 0
        }
        
        #Zombies also arise
        
        if(k %% 3 == 0){
          if(sqNet[i,j]==0 && zombieCnt==3){
            theLife[i,j] <- 1 
          }
        }     
   
        #if surrounded by zombies, humans transform
        
        if(sqNet[i,j]==2 && zombieCnt > humanCnt){
          theLife[i,j] <- 1
        }
      
      }
      
      # Interaction rules -------------------------------------------------------
      
      

      #if surrounded by humans, zombies die
      if(sqNet[i,j]==1 && humanCnt > zombieCnt){
        theLife[i,j] <- 0
      }



#       ##############################
#       # And they may walk
#       ##############################
#   
#       #choose a direction
#       
#       theWalk <- floor(runif(2, min=-1, max=2))
#       iWalk <- theWalk[1]+i
#       jWalk <- theWalk[2]+j
#       
#       #again the boundary conditions
#       
#       if(iWalk > m) iWalk <- 1
#       if(iWalk < 1) iWalk <- m
#       if(jWalk > m) jWalk <- 1
#       if(jWalk < 1) jWalk <- m
#       
#       #### The walking dead
#       
#       if(theLife[i,j]==1){
#         
#         #an empty space to walk
#         if (theLife[iWalk,jWalk]==0){
#           theLife[i,j] <- 0
#           theLife[iWalk,jWalk] <- 1
#         }  
#         
#       }
#       
#       #### The walking humans
#       
#       if(theLife[i,j]==2){
#         
#         #an empty space to walk
#         if (theLife[iWalk,jWalk]==0){
#           theLife[i,j] <- 0
#           theLife[iWalk,jWalk] <- 2
#         }  
# #        #don't hit a zombie or...
# #         if (theLife[iWalk,jWalk]==1){
# #           theLife[i,j] <- 1
# #         }  
#           #############################
#           # end walk
#           ##############################
#           #  
#       }
#       
      #############################
       #END OF RULES
      ############################

    } ###Loop j
    
  } ###Loop i

  cat("...........Humans and Zombies: ", length(theLife[theLife==2]), length(theLife[theLife==1]),"\n")
  X[,,k] <- theLife*(0.5) # capture results     
  sqNet <- theLife #write final result to compute next step

} ###Loop Step

Sys.time()-startTime

startTime <- Sys.time()
write.gif(X, "zombie.gif",col=jet.colors, delay=50)

cat("\n\n Writing gif  time (s): ",Sys.time()-startTime)
