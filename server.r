library(shiny)
source("funcoes.R")
library('qgraph')
library("wordcloud")
library(doBy)
library(DT)




shinyServer(function(input, output, session) {
  output$myplot <- renderPlot({
    sparse <- as.numeric(input$espaco)
    infile <- input$file1
    banco <-
      read.csv(infile$datapath,
               header = input$header,
               sep = input$sep)
    
    
    rede(
      banco,
      sparse = sparse,
      layoutNet = input$layout,
      posCol = input$posCol,
      negCol = input$negCol,
      correlation = input$correlation,
      clust = input$clust
    )
    output$mycentralidade <- renderPlot({
      centralityPlot(
        xx,
        include =  c(
          "ExpectedInfluence",
          "Strength",
          "Betweenness",
          "Closeness"
        ),
        orderBy = "ExpectedInfluence",
        print = FALSE
      )
    })
    output$wordFreq <- renderTable({
      wf <- data.frame(term = names(freq), occurrences = freq)
      head(orderBy( ~ -occurrences + term, data = wf), 25)
    })
    output$wordcloud <- renderPlot({
      wordcloud(
        words = text2[, 1],
        min.freq = 1,
        max.words = 100,
        random.order = FALSE,
        rot.per = 0.35,
        colors = brewer.pal(8, "Dark2")
      )
    })
  })
  
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    
    
    
    
    read.csv(inFile$datapath,
             header = input$header,
             sep = input$sep)
    
    
    
  })
  
  observe({
    inputfile <- input$file1
    
    # Can use character(0) to remove all choices
    if (is.null(inputfile)) {
      x <- NULL
    }
    else {
      x <-
        read.csv(inputfile$datapath,
                 header = input$header,
                 sep = input$sep)
      x = data.frame(lapply(x, as.character), stringsAsFactors = FALSE)
      dd <- unique(x[, 2])
      dd <- c(dd, '')
      updateSelectInput(
        session,
        "clust",
        label = NULL,
        choices =  dd,
        selected = ''
      )
    }
    
    
    
  })
  
  
  
  
})