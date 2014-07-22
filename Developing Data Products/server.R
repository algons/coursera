library("shiny")

tipModel <- function(bill,feedback){
  #Essentially every positive feedback counts for 5% tip
  positive.feedbacks <- length(feedback)
  tip <- bill*positive.feedbacks*0.05
  tip
}

shinyServer(
  function(input,output){
    output$o.bill <- renderPrint({input$bill})
    output$o.feedback <- renderPrint({input$feedback})
    output$tip <- renderPrint({tipModel(input$bill,input$feedback)})
    output$total <- renderPrint({input$bill + tipModel(input$bill,input$feedback)})
  }
)

