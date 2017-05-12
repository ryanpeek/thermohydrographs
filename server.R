library(shiny)

shinyServer(function(input, output) {
  
  data <- reactive({
    
    req(input$interval)
    req(input$sites)
    
    if(input$interval=="hourly"){
      h <- filter(hrly, site %in% input$sites & WY %in% input$years)
    } else {
      if(input$interval=="daily"){
        d <- filter(daily, site %in% input$sites & WY %in% input$years)
      } else {
        if(input$interval=="d7"){
          d7 <- filter(daily, site %in% input$sites & WY %in% input$years)
        }
      }
    }
  })

  output$caption <- renderText({
    input$caption
  })
  
  output$summary <- renderPrint({ 
    dataset<-data()
    summary(dataset)
  })

  # a large table reactive to input
  output$mytable1 = renderDataTable({
    datatab<-data()
    datatab
  }, options=list(lengthMenu=c(10,50,100),pageLength=10))
  
  output$plot <- renderPlot({
    dataplot<-data()
    if(input$interval=="hourly"){

      # Plot
      thermohydro1<-(ggplot() + 
                       geom_line(data=dataplot, 
                                 aes(x=datetime, y=level_comp, colour=temp_C),
                                 size=0.65, alpha=1) +
                       ylab("Stage (m)") + xlab("") +
                       scale_x_datetime(breaks=date_breaks("1 months"),
                                        labels = date_format("%b")) +

                       scale_colour_gradientn("Water \nTemp (C)",
                                              colours=palette(palette),
                                              values=breaks, 
                                              rescaler = function(x, ...) x,
                                              oob = identity,limits=c(0,30),
                                              breaks=breaks, 
                                              space="Lab") + 
                       theme_bw() + labs(title="Hourly Thermohydrograph")+
                       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
                       facet_grid(.~WY, scales = "free_x"))
      
      print(thermohydro1)
    } else {
      if(input$interval=="daily"){

        thermoday<-(ggplot() + 
                      geom_line(data=dataplot, aes(x=as.Date(date), y=lev.avg,
                                                   colour=temp.avg),
                                size=0.75,alpha=1) +
                      ylab("Stage (m)") + xlab("") + 
                      # scale_x_continuous(breaks=c(182,213,244,274,305, 
                      #                             335,1,32,60,92,122,152), 
                      #                    labels=c("Jul-1","Aug-1","Sep-1","Oct-1",
                      #                             "Nov-1","Dec-1","Jan-1","Feb-1",
                      #                             "Mar-1","Apr-1","May-1","Jun-1"))+
                      scale_x_date(breaks=date_breaks("1 months"),
                                   labels = date_format("%b"))+
                      scale_colour_gradientn("Water \nTemp (C)", 
                                             colours=palette(palette), 
                                             values=breaks, 
                                             rescaler = function(x, ...) x,
                                             oob = identity,limits=c(0,30), 
                                             breaks=breaks, space="Lab") +
                      theme_bw() + labs(title="Daily Thermohydrograph") +
                      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
                      facet_grid(.~WY, scales="free_x"))
        print(thermoday)
      } else {
        thermohydro2<-(ggplot() + 
                         geom_line(data=dataplot,
                                   aes(x=as.Date(date), y=lev.7.avg,
                                       colour=temp.7.avg), size=0.85,alpha=1) +
                         ylab("Stage (m)") + xlab("") +
                         scale_x_date(breaks=date_breaks("1 months"),
                                      labels = date_format("%b")) +
                         scale_colour_gradientn("Water \nTemp (C)",
                                                colours=palette(palette), 
                                                values=breaks, 
                                                rescaler = function(x, ...) x,
                                                oob = identity,limits=c(0,30), 
                                                breaks=breaks, space="Lab") + 
                         theme_bw() + labs(title="7 Day Average Thermohydrograph") +
                         theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
                         facet_grid(.~WY,scales="free_x"))
        print(thermohydro2)
      }
    }
  })
  
  output$plot2 <- renderPlot({
    dataplot<-data()
    if(input$interval=="hourly"){
      
      thermo1<- ggplot() + 
        geom_line(data=dataplot[month(dataplot$datetime)>3 & 
                                  month(dataplot$datetime)<10,],
                  aes(x=datetime, y=temp_C, colour=temp_C), size=0.7,alpha=1) +
        ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
        scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3), limits = c(0,30))+
        stat_smooth(data=dataplot[month(dataplot$datetime)>3 & 
                                    month(dataplot$datetime)<10,], 
                    aes(x=datetime, y=temp_C), color="gray50",alpha=0.5) +
        scale_x_datetime(breaks=date_breaks("1 month"),
                         labels = date_format("%b")) +
        scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                               values=breaks, rescaler = function(x, ...) x,
                               oob = identity,limits=c(0,30), 
                               breaks=breaks, space="Lab") +
        theme_bw() + labs(title="Hourly Water Temps") + 
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
      
      print(thermo1 + facet_grid(.~WY,scales="free",drop=T))
      
    } else {
      if(input$interval=="daily"){
        thermo2<- ggplot() + 
          geom_line(data=dataplot[month(dataplot$date)>3 & 
                                    month(dataplot$date)<10,],
                    aes(x=as.Date(date), y=temp.avg, colour=temp.avg), 
                    size=0.85,alpha=1) +
          ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
          scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3), limits = c(0,30))+
          stat_smooth(data=dataplot[month(dataplot$date)>3 & 
                                      month(dataplot$date)<10,], 
                      aes(x=as.Date(date), y=temp.avg),
                      color="gray50",alpha=0.5) +
          scale_x_date(breaks=date_breaks("1 month"), 
                           labels = date_format("%b")) +
          scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                                 values=breaks, rescaler = function(x, ...) x,
                                 oob = identity,limits=c(0,30), 
                                 breaks=breaks, space="Lab") +
          theme_bw() + labs(title="Daily Water Temps") + 
          theme(axis.text.x = element_text(angle = 45, hjust = 1))      
        print(thermo2 + facet_grid(.~WY,scales="free",drop=T))        
      } else {
        if(input$interval=="d7"){
          thermo3<- ggplot() + 
            geom_line(data=dataplot[month(dataplot$date)>3 & 
                                      month(dataplot$date)<10,],
                      aes(x=as.Date(date), y=temp.7.avg, 
                                        colour=temp.7.avg), size=0.85,alpha=1) +
            ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
            scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3), 
                               limits = c(0,30)) +
            stat_smooth(data=dataplot[month(dataplot$date)>3 & 
                                        month(dataplot$date)<10,], 
                        aes(x=as.Date(date), y=temp.7.avg), 
                        color="gray50",alpha=0.5)+
            scale_x_date(breaks=date_breaks("1 month"), 
                             labels = date_format("%b")) +
            scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                                   values=breaks, rescaler = function(x, ...) x,
                                   oob = identity,limits=c(0,30), 
                                   breaks=breaks, space="Lab") +
            theme_bw() + labs(title="7-Day Average Water Temps") + 
            theme(axis.text.x = element_text(angle = 45, hjust = 1))      
          print(thermo3 + facet_grid(.~WY,scales="free",drop=T))        
        }
      }
    }
  })
 
  output$map = renderLeaflet({
    
    # make map of Sites

    # USING RGDAL:
    # wgs84<-"+proj=longlat +datum=WGS84" # projection used
    
    # read in some shapefiles and make spatial
    #pts <- readOGR("shps/CWS_monitoring_sites.shp")
    
    # USING SF:read in some shapefiles and make spatial
    pts<-sf::read_sf("shps/CWS_monitoring_sites.shp")

    # Make map    
    leaflet() %>% 
      addProviderTiles("OpenStreetMap.BlackAndWhite", group = "B&W") %>%
      addProviderTiles("Esri.WorldImagery", group = "ESRI Aerial") %>%
      addProviderTiles("Esri.WorldTopoMap", group = "ESRI Topo") %>%
      addProviderTiles("Esri.NatGeoWorldMap", group = "ESRI World") %>% 
      addCircles(data=pts, weight=10, color= "maroon") %>% 
      #addMarkers(data=pts, popup = pts@data$Name) %>% # rgdal
      addMarkers(data=pts, popup = pts$Name) %>% # sf
      addLayersControl(
        baseGroups = c("B&W", "ESRI Topo", "ESRI Aerial", "ESRI World"),
        options = layersControlOptions(collapsed = T))
    
  })

  output$downloadData <- downloadHandler(
    filename = function() { paste(input$data, '.csv', sep='') },
    content = function(file) {
      write.csv(data(), file, row.names = F)
    }
  )
})  


