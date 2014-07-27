library("shiny")

shinyUI(pageWithSidebar(
  headerPanel("Tip calculator"),
  sidebarPanel(
    sliderInput('bill','Your bill (£)',min=0,max=200,value=0,step=1),
    sliderInput('size','Number of people dining',min=1,max=8,value=1,step=1),
    br(),
    checkboxGroupInput("feedback","Feedback on the dinner",
                       c("The waitress was a smiling person (5%)"="Smiling",
                         "The food arrived on time (5%)"="Punctual",
                         "The service quality was high (5%)"="High-quality",
                         "The food was delicious (5%)"="Delicious"))
  ),
  mainPanel(
    tabsetPanel(
      
      #This is where the real application is
      tabPanel("Application", 
               h4('Your bill is:'),
               verbatimTextOutput("o.bill"),
               h4('Your group size is:'),
               verbatimTextOutput("o.size"),
               h4('Your feedback about the place is:'),
               verbatimTextOutput("o.feedback"),
               br(),
               h4('Your tip could be around:'),
               verbatimTextOutput("tip"),
               h4('Your total payment could be around:'),
               verbatimTextOutput("total")
      ),
      
      #This is where the documentation is
      tabPanel("Documentation", 
               p('These instructions serve as the documentation of this application'),
               br(),
               p('This is a fairly simple application (similar to the one in the class, but prediction logic is different)'),
               p("Scenario: You go to a restaurant and don't know how much you should tip"),
               p("This model helps you to calculate the tip you could leave - based on your bill and your thoughts about the place"),
               br(),
               
               h4('Input instructions'),
               tags$ul(
                 tags$li("Use the first slider on the sidebar to enter the bill that you received in the restaurant"), 
                 tags$li("Use the second slider to tell the number of people you had the dinner with"), 
                 tags$li("Then check the positive feedback boxes depending on your experience"),
                 tags$ul(
                   tags$li("Each positive feedback represent a 5% tip you could leave - on top of the min 5% which is kind of social norm"),
                   tags$li("Reserach shows that as the dining group size increases, slightly less tip is left (1%)*"),
                   tags$li("Also the increasing bill reduces the tip percentage-wise")
                 )
               ),
               span("*:"),a("http://www.info.univ-angers.fr/~gh/Datasets/tips_cs503.pdf",target="_blank"),
               br(),
               
               h4('Model calculation'),
               p("Inputs are 'bill' (numeric object) and 'feedbacks' (character vector) "),
               p("Below function calculates the tip amount"),
               code("tipModel <- function(bill,feedback,size){"),br(),
               code("   feedback.reward <- length(feedback)*0.05 + 0.05"),br(),
               code("   size.penalty <- (1 - size*0.01)"),br(),
               code("   bill.penalty <- (1 - bill*0.001)"),br(),
               code("   tip <- round(bill*feedback.reward*size.penalty*bill.penalty,1)"),br(),
               code("   tip"),br(),
               code("}"),br(),
               br(),
               
               h4('Output instructions'),
               p('Outputs are displayed in the main panel'),
               p('First your inputs are displayed:'),
               tags$ul(
                 tags$li("Your bill (£)"),
                 tags$li("Your group size"),
                 tags$li("Your feedbacks")
               ),
               p('Then the calculations are displayed:'),
               tags$ul(
                 tags$li("Tip = your bill * (# of positive feedbacks+1) * (5%) * group size penalty * bill benalty"),
                 tags$li("Total payment = Your bill + Tip")
               )
      )
    )
  )
))
