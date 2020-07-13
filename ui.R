library(shiny)


options(shiny.maxRequestSize = 30*1024^2)

fluidPage(navbarPage(
  'Graph Network Analysis with Text',
  tabPanel(
    "Loading File",
    h3("Loading File"),
    h5(
      "Attention! Select the options below correctly before loading the data."),
    h5('This application was designed to accept only files with two columns considering the first column the text and the second column the cluster.'),
    h5('You need to upload a file with at least two columns. '),
     checkboxInput("header", "if your file has a HEADER check it", TRUE),
    
    radioButtons(
      'sep',
      'Separator',
      c(
        Comma = ',',
        Semicolon = ';',
        Tab = '\t',
        Pipe = '|'
      ),
      ','
    ),
    fileInput(
      "file1",
      "Choose CSV File",
      accept = c("text/csv",
                 "text/comma-separated-values,text/plain",
                 ".csv")
    ),
    
    tags$hr(),
    mainPanel(tableOutput("contents"))
  ),
  tabPanel(
    "Analysis",
    
    
    tags$head(tags$style(
      HTML("hr {border-top: 1px solid #000000;}")
    )),
    
    fluidRow(
      column(
        3,
        h3("Settings"),
        
        selectInput(
          'layout',
          label = 'Select a network layout',
          choices = c(
            'spring' = 'spring',
            'circle' = 'circle' ,
            'groups' = 'groups'
          ),
          selected = 'spring'
        ),
        selectInput('clust',
                    label = 'Select a cluster to filter and view',
                    choices = c('All' = '')),
        selectInput(
          'correlation',
          label = 'Choose a type of correlation',
          choices = c(
            'pearson' = 'pearson',
            'spearman' = 'spearman',
            'kendall' = 'kendall'
          ),
          selected = 'spearman'
        ),
        selectInput(
          'posCol',
          label = 'Select a color for the positive correlations',
          choices = c(
            'white' = 'white',
            'darkgreen' = 'darkgreen',
            'blue' = 'blue'
          ),
          selected = 'blue'
        ),
        selectInput(
          'negCol',
          label = 'Select a color for the negative correlations',
          choices = c(
            'white' = 'white',
            'orange' = 'orange',
            'red' = 'red'
          ),
          selected = 'white'
        ),
        sliderInput(
          'espaco',
          "Remove removeSparseTerms",
          min = 0,
          max = 0.99,
          value = 0.96
        ),
        hr(),
        h3("WordClound"),
        fluidRow(plotOutput("wordcloud"))
      ),
      column(
        7,
        h3("Network with qgraph"),
        plotOutput("myplot", width = "100%"),
        
        h3("CentralityPlot"),
        plotOutput("mycentralidade"),
        style = 'border-right:1px solid;border-left:1px solid ',
      ),
      column(2,
             h3("Terms Frequency"),
             tableOutput("wordFreq"))
    )
  )
))
