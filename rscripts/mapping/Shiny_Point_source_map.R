#Load libraries for Rshiny

library(shiny)
library(leaflet)
library(leaflet.extras)

#make uk map
#Divide emissions weights into categories
#Small 0 - 10 Tonnes /year
#Medium 10 - 100 Tonnes/year
#Large 100 - 2000000 Tonnes/Year

dat_SP_LL$Emission_type <- ifelse(dat_SP_LL$Emission <= 10, "Small", ifelse(dat_SP_LL$Emission <= 100 | dat_SP_LL$Emission >10, "Medium", ifelse(data$depth > 100,"Large","other")))

#plot emission sources on map

#Set up Rshiny UI

ui <- fluidPage(
  mainPanel(
    #this will create a space for us to display our map
    leafletOutput(outputId = "Emissions Map"),
    #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
    absolutePanel(top = 60, left = 20,
                  checkboxInput("markers", "Emission", FALSE),
                  checkboxInput("heat", "Heatmap", FALSE)
    )
  ))

#Set up RhinyServer

server <- function(input, output, session) {
  #define the color pallate for the magnitidue of the earthquake
  #pal <- colorNumeric(
  #  palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
  #  domain = dat_SP_LL$Emission_type)

  #define the color of for the depth of the earquakes
  pal2 <- colorFactor(
    palette = c('blue', 'yellow', 'red'),
    domain = dat_SP_LL$Emission_type
  )

  #create the map
  output$mymap <- renderLeaflet({
    leaflet(dat_SP_LL) %>%
      setView(lng = 2, lat = 54, zoom = 1)  %>% #setting the view over ~ center of North America
      addTiles() %>%
      addCircles(data = dat_SP_LL, lat = ~ Lat, lng = ~ Long, weight = 1, radius = ~sqrt(dat_SP_LL$Emission)*25000, popup = ~as.character(Dat_SP_LL$Emission), label = ~as.character(paste0("Emission: ", sep = " ", dat_SP_LL$Emission)), color = ~pal(dat_SP_LL$emission), fillOpacity = 0.5)
  })

  #next we use the observe function to make the checkboxes dynamic. If you leave this part out you will see that the checkboxes, when clicked on the first time, display our filters...But if you then uncheck them they stay on. So we need to tell the server to update the map when the checkboxes are unchecked.
  observe({
    proxy <- leafletProxy("mymap", data = dat_SP_LL)
    proxy %>% clearMarkers()
    if (input$markers) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal2(Emission_type), fillOpacity = 0.2,      label = ~as.character(paste0("Emission: ", sep = " ", Emission))) %>%
        addLegend("bottomright", pal = pal2, values = dat_SP_LL$Emission_type,
                  title = "Emission Category",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })

  observe({
    proxy <- leafletProxy("mymap", data = dat_SP_LL)
    proxy %>% clearMarkers()
    if (input$heat) {
      proxy %>%  addHeatmap(lng=~Long, lat=~Lat, intensity = ~dat_SP_LL$Emission, blur =  10, max = 0.05, radius = 15)
    }
    else{
      proxy %>% clearHeatmap()
    }


  })

}

#Create Shiny App

shinyApp(ui, server)
