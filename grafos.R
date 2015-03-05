library(Rgraphviz)
test.matrix<-matrix(rep(c(0,1,1,0), 9), ncol=6, nrow=6)
rownames(test.matrix)<-c("a", "b", "c", "d", "e", "f")
colnames(test.matrix)<-c("a", "b", "c", "d", "e", "f")
test.matrix

am.graph<-new("graphAM", adjMat=test.matrix, edgemode="directed")
am.graph
#A graphAM graph with directed edges
#Number of Nodes = 6 
#Number of Edges = 9 
plot(am.graph, attrs = list(node = list(fillcolor = "lightblue"),
                              edge = list(arrowsize=0.5)))

