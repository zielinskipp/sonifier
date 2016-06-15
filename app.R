library(shiny)
library(tuneR)
library(seewave)
library(stringi)

source("functions/sonify.R")
source("functions/audiotag.R")


ui <- fluidPage(
  titlePanel("Sonify your name (or any text)!!!"),
  
  sidebarPanel(
    textInput("name", label = h3("Tell me your name"), value = "Shiny"),
    
    selectInput("wave_type", "Signal:", c("Sine" = "sine", "Pulse" = "pulse",
                                          "Sawtooth" = "sawtooth", 
                                          "Square" = "square")),
    actionButton("button", "SONIFY!!!")
),
  
  
  mainPanel(
    uiOutput("audiotag"),
    textOutput("text"),
    textOutput("click"),
    plotOutput("spectro")
    
  )
)
  
  
  
server <- function(input, output){
  
  
  output$text <- renderText({input$name})
  
  observeEvent(input$button, {
    output$click <- renderText({input$button})
    
  })
  
  
  
  observeEvent(input$button, {
  sound <- sonify(input$name, input$wave_type) 

  
  wvname <- paste0("sound", input$button,".wav")
  writeWave(sound, paste0("www/", wvname))
  
  output$spectro <- renderPlot(spectro(sound, flim = c(0,5)))
  
  output$audiotag <- renderUI(audiotag(wvname))
  })
  
}
  
  
  
  
shinyApp(ui = ui, server = server)

