library(shiny)

shinyServer(function(input, output, session) {
    
    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    output$mymap <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%
            addMarkers(lat = 5.967162798 , lng = -62.534664528, popup =  "'El Salto Angel... World's highest waterfall")
    })
})


