library(shiny)
library(rmarkdown)
library(ggplot2)

dataset <- mtcars

shinyUI(navbarPage("",
 
  tabPanel("plot",
 
  headerPanel("Finding the best mileage combination"),
 
  
  sidebarPanel(

    
    selectInput( 'cyl', 'Choose number of cylinders', sort(unique(dataset$cyl))),
    selectInput( 'x', 'Select X - Axis', c("hp","disp","drat","wt","qsec")),
    'Y - axis is mpg'
  ),
  
 
  mainPanel(

   h3('plot of the relatoinship'),
   plotOutput('plot'),
   h3('Regression Equation'),
    textOutput('eq'),
   h3('R Square of the model'),
   textOutput('rsquared'),
   h3('Data selected for the analysis'),
   dataTableOutput('df')
    )
  ),
  
  tabPanel("Read me", includeMarkdown("include.Rmd")
  )
))