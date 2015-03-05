 #########################################################
 #########################################################
 #          Rules for an  Almost random walk
 #########################################################
 #########################################################

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
