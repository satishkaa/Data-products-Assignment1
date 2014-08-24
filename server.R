library(shiny)
library(ggplot2)

extr_eqn = function(m) {
   
  
  if (coef(m)[2] >= 0)  {
    eq <- sprintf("mpg = %f + %f %s ",coef(m)[1],abs(coef(m)[2]), names(coef(m)[2]))
  } else {
    eq <- sprintf("mpg = %f - %f %s ",coef(m)[1],abs(coef(m)[2]), names(coef(m)[2]))   
  }
  
         
}



shinyServer(function(input, output) {
  
  dataset <- reactive( {
  mtcars[mtcars$cyl == input$cyl, ] 
  } )

    
  output$plot <- renderPlot(function(){
    
    p <- ggplot(dataset(), aes_string(x=input$x, y="mpg")) + geom_smooth(method = "lm", formula = y ~ x) + geom_point()
    print(p)
  })

  
  model <- reactive ({
    
    f <- paste("mpg ~ ",input$x, sep = "")
    lm(as.formula( f ), dataset())
    
  })
 

  eqn <- reactive ({
    
    extr_eqn(model())

  })

  
 
  
  output$eq <- renderText({eqn()})
  output$rsquared <- renderText({summary(model())$r.squared})
  output$df <-  renderDataTable({dataset()})

 })