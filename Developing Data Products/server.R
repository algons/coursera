library("shiny")

tipModel <- function(bill,feedback,size){
  #Essentially every positive feedback counts for 5% tip on top of 5% minimum tip (social norm)
  feedback.reward <- length(feedback)*0.05 + 0.05
  #Every incremental person in the group reduces the bill by 1%
  size.penalty <- (1 - size*0.01)
  #People tend to pay percentage-wise less tips when the bill is higher
  bill.penalty <- (1 - bill*0.001)
  tip <- round(bill*feedback.reward*size.penalty*bill.penalty,1)
  tip
}

shinyServer(
  function(input,output){
    output$o.bill <- renderPrint({input$bill})
    output$o.size <- renderPrint({input$size})
    output$o.feedback <- renderPrint({input$feedback})
    output$tip <- renderPrint({tipModel(input$bill,input$feedback,input$size)})
    output$total <- renderPrint({input$bill + tipModel(input$bill,input$feedback,input$size)})
  }
)

