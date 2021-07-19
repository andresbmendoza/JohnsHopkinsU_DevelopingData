#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
# Keeping just the variables for analysis: Cut, Color, Clarity, Carat and the predicted value Price
diam <- diamonds[,c(1:4,7)]
summary(diam)
# Code for generate a plotly grpfh from a ggplot2 one and:
shinyServer(function(input, output) {
    output$distPlot <- renderPlotly({
        # Modifying the Database DB
        DB <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        # Building a Linear Regression Model  based on the variables selection on UI:
        fit <- lm( price~carat, DB)
        # predicts the price 
        predicted <- predict(fit, newdata = data.frame(carat = input$car,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar), interval = "predict")
        # Drawing a ggplot2:
        plot <- ggplot(data = DB, aes(x=carat, y = price))+
            geom_point(aes(color = cut), alpha = 0.2)+
            geom_smooth(method = "lm")+
            geom_vline(xintercept = input$car, color = "red")+                  #Predictor Value Carat
            geom_hline(yintercept = predicted, color = "green")                 #show three h. lines: Expected and predicted intervals values (min-max)
        
        # Converting the ggplot2 graph into Plotly graph
        ggplotly(plot)
    })
    output$FinalTable <- renderTable({
        # renders the text for the prediction below the graph
        diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        fit <- lm( price~carat, diam)
        predicted <- predict(fit, newdata = data.frame(carat = input$car,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar), interval = "predict")
       # Creating the Data frame to show:
        predicted <- as.data.frame( round(predicted, 2))
        names(predicted) <- c("Expected", "Minimun", "Maximun")
        
        #Handle the unrealistics values (prices below zero) display 
        #"Unrealistic value in expected price and the lower limit is fitted to zero
        if (predicted$Expected < 0) {
            predicted$Expected <- "Unrealistic value"
            predicted$Minimun <- 0
        }
        predicted
    })
    
})