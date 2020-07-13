



#banco <- read.csv(file.choose(), sep = ",")

library(tm)
library(NLP)
library(qgraph)

rede <-
  function(text1, sparse, layoutNet, posCol, negCol, correlation,
           clust) {
    
    if ( is.null(clust) || clust == '') {
      text = data.frame(text1)
    }else{
      text = data.frame(lapply(text1, as.character), stringsAsFactors=FALSE)
      text = data.frame(text[text[, 2] == as.character(clust) , c(1, 2)])
    }
    
    
    text2 <<- text
    df1 <- as.vector(text[, 1])
    
    corpus <- Corpus(VectorSource(df1))
    
    #Limpeza
    #removendo pontuações e números
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    
    
    #cria uma matriz de documentos e termos
    dtm <- DocumentTermMatrix(corpus)
    
    #Frequenia
    freq <<- colSums(as.matrix(dtm))
    
    dtm <- removeSparseTerms(dtm, sparse)
    
    cor <- cor(as.matrix(dtm), method = correlation)
    
    title1 = paste("Words in the network:", dtm$ncol)
    xx <<-
      qgraph(
        cor,
        layout = layoutNet,
        sampleSize = nrow(text),
        posCol = posCol,
        negCol = negCol,
        labels = colnames(dtm),
        label.cex = 1.1,
        title = title1
      )
    
    
  }


