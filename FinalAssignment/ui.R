
library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Diamond price prediction Based On Choosen Characteristics"),
    h4(helpText("Please Wait until graph appears!")),
    
    # Sidebar with options selectors 
    sidebarLayout(
        sidebarPanel(
            helpText("This application estimate the Expected Value of a diamond, based on some characteristics, such as: Carats, Cut, Color and Clarity."),
            h3(helpText("Select:")),
            sliderInput("car", label =  h4("Carats") ,min = 0.1, max = 5.5, value = 2.8),
            selectInput("cut", label = h4("Cut"), 
                        choices = list("Unknown" = "*", "Fair" = "Fair", "Good" = "^Good",
                                       "Very Good" = "Very Good", "Premium" = "Premium",
                                       "Ideal" = "Ideal")),
            selectInput("col", label = h4("Color"), 
                        choices = list("Unknown" = "*", "D" = "D", "E" = "E",
                                       "F" = "F", "G" ="G",
                                       "H" = "H", "I" = "I",
                                       "J" = "J")),
            selectInput("clar", label = h4("Clarity"), 
                        choices = list("Unknown" = "*", "I1" = "I1", "SI2" = "SI2",
                                       "SI1" = "SI1", "VS2" = "VS2", "VS1" = "VS1",
                                       "VVS2" = "VVS2", "VVS1" = "VVS1", "IF" = "IF" )),
            submitButton(text = "Run the Estimate!")
        ),
        
        # Show a plot with diamonds and regression line
        mainPanel(
            plotlyOutput("distPlot"),
            h4("Predicted value of this diamond in U$D within a 95% of confidence is:"),
            tableOutput("FinalTable")
        )
    )
))
