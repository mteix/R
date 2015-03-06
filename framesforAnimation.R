frames = 50

for(i in 1:frames){
  # creating a name for each plot file with leading zeros
  if (i < 10) {name = paste('000',i,'plot.png',sep='')}
  if (i < 100 && i >= 10) {name = paste('00',i,'plot.png', sep='')}
  if (i >= 100) {name = paste('0', i,'plot.png', sep='')}
  
  x = seq(0, i, 1)
  f.3 = dbinom(x, size = i, prob=.3)
  f.7 = dbinom(x, size = i, prob=.7)
  
  #saves the plot as a .png file in the working directory
  png(name)
  plot(x, f.3, type='h', xlim = c(0,frames), ylim = c(0,.7), ylab ='probability',   main = paste('Binomial density with n = ', i), col = 'red')
  lines(x,f.7,type='h',col='blue')
  text(45, .6, 'p = .3', col='red')
  text(45, .6, 'p = .7', col='blue', pos=1)
  dev.off()
}