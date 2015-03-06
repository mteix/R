
#This will be the zommbie code
#
#05-May-2015
#
# Test version:
#Improved plot functions 
#levelPlot


rm(list=ls())

setwd("C:/Users/edbmjtx/Documents/Github")


#Time measured

#ptm <- proc.time()
#proc.time() - ptm

startTime <- Sys.time()
iter <- 100

m <- 500 # define size



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



# AUTOMATA + ZOMBIE RULES -------------------------------------------------

cat ("Iterations Completed: \n")

# frames  = steps

#ch.col = c("white","red","blue") # define colors

  for (k in 1:iter) {  
    
   # creating a name for each plot file with leading zeros
    if (k < 10) {name = paste('000',k,'plot.png',sep='')}
    if (k < 100 && k>= 10) {name = paste('00',k,'plot.png', sep='')}
    if (k >= 100) {name = paste('0', k,'plot.png', sep='')}
    
  
    png(file = name, width = 480, height = 480, units = "px", pointsize = 12)
    
    image(theLife, xlab="", ylab="",col=c("white","red","blue"))

    dev.off()
    
  
    cat (".")
    
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
  
  
      } ###Loop j
      
    } ###Loop i
  
    #cat("...........Humans and Zombies: ", length(theLife[theLife==2]), length(theLife[theLife==1]),"\n")
        
    sqNet <- theLife #write final result to compute next step

  } ###Loop Step
  



cat("\n\n")

print(Sys.time()-startTime)

