library(shiny)
library(tuneR)
library(seewave)
library(stringi)
library(markdown)

source("functions/sonify.R")
source("functions/audiotag.R")


ui <- fluidPage(tabsetPanel(
  
  tabPanel("App", 
           
  titlePanel("Sonify your name (or any text)!!!"),
  
  sidebarPanel(
    textInput("name", label = h3("Tell me your name"), value = "Shiny"),
    
    selectInput("wave_type", "Signal:", c("Sine" = "sine", "Pulse" = "pulse",
                                          "Sawtooth" = "sawtooth", 
                                          "Square" = "square")),
    
    checkboxInput("atten", label = "Attenuation", value = TRUE),
    actionButton("button", "SONIFY!!!"),
    downloadButton("wav_dln", label = "Download")
),

  mainPanel(
    
    textOutput("text"),
    uiOutput("audiotag"),
    plotOutput("spectro")
    
  )),

tabPanel("Documentation",
    includeMarkdown("README.md")
         
)))
  
  
  
server <- function(input, output){
  
  
## Sonification event: generation, saving, downloading, playing
  observeEvent(input$button, {

  output$text <- renderText({
    paste0("Your input, ", input$name, ", sounds like this:")})
  sound <- sonify(input$name, input$wave_type, input$atten) 

  # Saves file
  wvname <- paste0("sound", input$button,".wav")
  writeWave(sound, paste0("www/", wvname))
  
  # Creates spectrogram {seewave}
  output$spectro <- renderPlot(spectro(sound, flim = c(0,5)))
  
  # Creates audiotag
  output$audiotag <- renderUI(audiotag(wvname))
  
  ## Dawnload handler
  output$wav_dln <- downloadHandler(
    filename = function(){
      paste0("sound", input$button, ".wav")
    },
    content = function(filename){
      writeWave(sound, filename)
    }
  )
  })
}
  
  
  
  
shinyApp(ui = ui, server = server)

