#Load libraries for Rshiny

library(shiny)
library(leaflet)
library(leaflet.extras)
library(dplyr)

#make uk map
#Divide emissions weights into categories
#Small 0 - 10 Tonnes /year
#Medium 10 - 100 Tonnes/year
#Large 100 - 2000000 Tonnes/Year


dat_SP_LL$Emission_type <- ifelse(dat_SP_LL$Emission_type <= 10, "Small", ifelse(dat_SP_LL$Emission_type <= 100 | dat_SP_LL$Emission_type >10, "Medium", ifelse(dat_SP_LL$Emission_type > 100,"Large","other")))

#Put in UI (User Interface Code) for Shiny

ui <- fluidPage(
  mainPanel(
    #this will create a space for us to display our map
    leafletOutput(outputId = "mymap"),
    #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
    absolutePanel(top = 60, left = 20,
                  checkboxInput("markers", "Emission", FALSE),
                  checkboxInput("heat", "Heatmap", FALSE)
    )
  ))

#Add code for Rhiny Server (settings for server!)

server <- function(input, output, session) {
  #define the color pallate for the magnitidue of the earthquake
  pal <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = dat_SP_LL$Emission)

  #define the color of for the depth of the earquakes
  pal2 <- colorFactor(
    palette = c('blue', 'yellow', 'red'),
    domain = dat_SP_LL$Emission
  )

  #create the map
  output$mymap <- renderLeaflet({
    leaflet(dat_SP_LL) %>%
      setView(lng = 2, lat = 54, zoom = 2)  %>% #setting the view over ~ center of North America
      addTiles() %>%
      addCircles(data = dat_SP_LL, lat = ~ Lat, lng = ~ Long, weight = 1, radius = 0.01, popup = ~as.character(Emission), label = ~as.character(paste0("Emission (Tonnes): ", sep = " ", Emission)), color = ~pal(Emission), fillOpacity = 0.5)
  })

  #next we use the observe function to make the checkboxes dynamic. If you leave this part out you will see that the checkboxes, when clicked on the first time, display our filters...But if you then uncheck them they stay on. So we need to tell the server to update the map when the checkboxes are unchecked.
  observe({
    proxy <- leafletProxy("mymap", data = dat_SP_LL)
    proxy %>% clearMarkers()
    if (input$markers) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal2(Emission_type), fillOpacity = 0.2,      label = ~as.character(paste0("Emission Type: ", sep = " ", Emission))) %>%
        addLegend("bottomright", pal = pal2, values = dat_SP_LL$Emission_type,
                  title = "Emission Type",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })

  observe({
    proxy <- leafletProxy("mymap", data = dat_SP_LL)
    proxy %>% clearMarkers()
    if (input$heat) {
      proxy %>%  addHeatmap(lng=~Long, lat=~Lat, intensity = ~Emission, blur =  0.1, max = 0.05, radius = 1)
    }
    else{
      proxy %>% clearHeatmap()
    }


  })

}

#Rshiny App

shinyApp(ui, server)
