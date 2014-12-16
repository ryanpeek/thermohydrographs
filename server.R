library(shiny)

shinyServer(function(input, output) {
  
  data <- reactive({
    if(input$interval=="hourly" & input$singlemon == TRUE){
      h <- filter(hrly, site %in% input$sites & year %in% input$years & mon %in% input$mon)
      #h <- hrly[hrly$site %in% input$sites & hrly$year %in% input$years & hrly$mon %in% input$mon,]
      h
    } else {
      if(input$interval=="hourly" & input$singlemon == FALSE){
        h <- filter(hrly, site %in% input$sites & year %in% input$years)
        h
        } else {
          if(input$interval=="daily" & input$singlemon == TRUE){
            #d <- daily[daily$site %in% input$sites & daily$year %in% input$years,]
            d <- filter(daily, site %in% input$sites & year %in% input$years & mon %in% input$mon)
            d
          } else {
            if(input$interval=="daily" & input$singlemon == FALSE){
              d <- filter(daily, site %in% input$sites & year %in% input$years)
              d
              } else {
              if(input$interval=="d7" & input$singlemon == TRUE){
                d7 <- filter(daily, site %in% input$sites & year %in% input$years & mon %in% input$mon)
                d7
                } else {
                  if(input$interval=="d7" & input$singlemon == FALSE){
                    d7 <- filter(daily, site %in% input$sites & year %in% input$years)
                    d7
                  }
                }
              }
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
  }, options=list(aLengthMenu=c(10,50,100),iDisplayLength=10))
  
  output$plot <- renderPlot({
    dataplot<-data()
    if(input$interval=="hourly"){
      # TO FILTER OUT DISCONTINUOUS DATA use breaks as groups and add to aes()
#       idx<-c(1,diff(dataplot$yday)) # make a diff column
#       i2<-c(1,which(idx!=1),nrow(dataplot)+1) # compare which rows are are not diff by 15 min
#       dataplot$grp<-rep(1:length(diff(i2)),diff(i2)) #use group to assign each portion of plotted line
#       thermohydro1<-(ggplot() + geom_line(data=dataplot,aes(group=grp,x=yday, y=Level, colour=Temperature), size=0.65,alpha=1) +
      # Plot
      thermohydro1<-(ggplot() + geom_line(data=dataplot,aes(x=Datetime, y=Level, colour=Temperature), size=0.65,alpha=1) +
                       ylab("Stage (m)") + xlab("") +
                       scale_x_datetime(breaks=date_breaks("1 months"),labels = date_format("%b-%d"))+
#                        scale_x_continuous(breaks=c(182,213,244,274,305,335,1,32,60,92,122,152), 
#                                           labels=c("Jul-1","Aug-1","Sep-1","Oct-1",
#                                                    "Nov-1","Dec-1","Jan-1","Feb-1",
#                                                    "Mar-1","Apr-1","May-1","Jun-1"))+
                       scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                                              values=breaks, rescaler = function(x, ...) x, 
                                              oob = identity,limits=c(0,30), breaks=breaks, 
                                              space="Lab") +theme_bw() + 
                       labs(title="Hourly Thermohydrograph")+
                       theme(axis.text.x = element_text(angle = 45, hjust = 1))+
                       facet_grid(.~year, scales = "free_x"))
      
      print(thermohydro1)
    } else {
      if(input$interval=="daily"){
        # TO FILTER OUT DISCONTINUOUS DATA use breaks as groups and add to aes()
        #idx<-c(1,diff(dataplot$yday)) # make a diff column
        #i2<-c(1,which(idx!=1),nrow(dataplot)+1) # compare which rows are are not diff by 15 min
        #dataplot$grp<-rep(1:length(diff(i2)),diff(i2)) #use group to assign each portion of plotted line
        thermoday<-(ggplot() + geom_line(data=dataplot,aes(x=yday, y=lev.avg, colour=temp.avg), size=0.75,alpha=1) +
                      ylab("Stage (m)") + xlab("") + 
                      scale_x_continuous(breaks=c(182,213,244,274,305,335,1,32,60,92,122,152), 
                                         labels=c("Jul-1","Aug-1","Sep-1","Oct-1",
                                                  "Nov-1","Dec-1","Jan-1","Feb-1",
                                                  "Mar-1","Apr-1","May-1","Jun-1"))+
                      #scale_x_datetime(breaks=date_breaks("1 months"),labels = date_format("%b-%y"))+
                      scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette), 
                                             values=breaks, rescaler = function(x, ...) x, 
                                             oob = identity,limits=c(0,30), breaks=breaks, 
                                             space="Lab") +theme_bw() + 
                      labs(title="Daily Thermohydrograph")+
                      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
                      facet_grid(.~year))
        print(thermoday)
      } else {
        #if(input$interval=="d7"){
        # TO FILTER OUT DISCONTINUOUS DATA use breaks as groups and add to aes()
#         idx<-c(1,diff(dataplot$Datetime)) # make a diff column
#         i2<-c(1,which(idx!=1),nrow(dataplot)+1) # compare which rows are are not diff by 15 min
#         dataplot$grp<-rep(1:length(diff(i2)),diff(i2)) #use group to assign each portion of plotted line
        thermohydro2<-(ggplot() + geom_line(data=dataplot,aes(x=yday, y=lev.7.avg, colour=temp.7.avg), size=0.85,alpha=1) +
                         ylab("Stage (m)") + xlab("") +
                         scale_x_continuous(breaks=c(182,213,244,274,305,335,1,32,60,92,122,152), 
                                            labels=c("Jul-1","Aug-1","Sep-1","Oct-1",
                                                     "Nov-1","Dec-1","Jan-1","Feb-1",
                                                     "Mar-1","Apr-1","May-1","Jun-1"))+
                         #scale_x_datetime(breaks=date_breaks("1 months"),labels = date_format("%b-%y"))+
                         scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette), 
                                                values=breaks, rescaler = function(x, ...) x, 
                                                oob = identity,limits=c(0,30), breaks=breaks, 
                                                space="Lab") +theme_bw() + 
                         labs(title="7 Day Average Thermohydrograph")+
                         theme(axis.text.x = element_text(angle = 45, hjust = 1))+
                         facet_grid(.~year,scales="free"))
        print(thermohydro2)
      }
    }
  })
  
  output$plot2 <- renderPlot({
    dataplot<-data()
    if(input$interval=="hourly"){
      thermo1<- ggplot() + geom_line(data=dataplot,aes(x=Datetime, y=Temperature, colour=Temperature), size=0.7,alpha=1) +
        ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
        scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3))+
        stat_smooth(data=dataplot, aes(x=Datetime, y=Temperature),color="gray50",alpha=0.5)+
        scale_x_datetime(breaks=date_breaks("2 weeks"),labels = date_format("%m-%d"))+
        scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                               values=breaks, rescaler = function(x, ...) x,
                               oob = identity,limits=c(0,30), breaks=breaks, space="Lab") +
        theme_bw() + labs(title="Hourly Water Temps")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))      
      print(thermo1 + facet_grid(.~year,scales="free",drop=T))
    } else {
      if(input$interval=="daily"){
        thermo2<- ggplot() + geom_line(data=dataplot,aes(x=Datetime, y=temp.avg, colour=temp.avg), size=0.85,alpha=1) +
          ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
          scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3))+
          stat_smooth(data=dataplot, aes(x=Datetime, y=temp.avg),color="gray50",alpha=0.5)+
          scale_x_datetime(breaks=date_breaks("2 weeks"),labels = date_format("%m-%d"))+
          scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                                 values=breaks, rescaler = function(x, ...) x,
                                 oob = identity,limits=c(0,30), breaks=breaks, space="Lab") +
          theme_bw() + labs(title="Daily Water Temps")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))      
        print(thermo2 + facet_grid(.~year,scales="free",drop=T))        
      } else {
        if(input$interval=="d7"){
          thermo3<- ggplot() + geom_line(data=dataplot,aes(x=Datetime, y=temp.7.avg, colour=temp.7.avg), size=0.85,alpha=1) +
            ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
            scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3))+
            stat_smooth(data=dataplot, aes(x=Datetime, y=temp.7.avg),color="gray50",alpha=0.5)+
            scale_x_datetime(breaks=date_breaks("2 weeks"),labels = date_format("%m-%d"))+
            scale_colour_gradientn("Water \nTemp (C)",colours=palette(palette),
                                   values=breaks, rescaler = function(x, ...) x,
                                   oob = identity,limits=c(0,30), breaks=breaks, space="Lab") +
            theme_bw() + labs(title="7-Day Average Water Temps")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))      
          print(thermo3 + facet_grid(.~year,scales="free",drop=T))          
        }
      }
    }
  })
  
#   output$plot3 <- renderPlot({
#     df <- data()
#     df <- df[df$mon>=6 & df$mon<=8,]
#     if (input$interval=="d7") {      
#       d7plot<-ggplot()+ geom_line(data=df,aes(x=Datetime, y=Temperature.7),colour="black", size=0.75,alpha=1)+
#         geom_line(data=df,aes(x=Datetime, y=temp.max.7),colour="red", size=0.65,lty=2,alpha=1)+
#         scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3))+theme_bw()+
#         ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
#         labs(title="7-Day Average Water Temps")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+
#         scale_x_datetime(breaks=date_breaks("1 month"),labels = date_format("%m-%y"))+
#         geom_line(data=df,aes(x=Datetime, y=temp.min.7),colour="navyblue", size=0.65,lty=2,alpha=1)
#       print(d7plot+facet_grid(.~year,scales="free",drop=T))
#     } else {
#       if (input$interval=="daily") {
#         
#         dplot<-ggplot()+ geom_line(data=df,aes(x=Datetime, y=Temperature),colour="black", size=0.75,alpha=1)+
#           geom_line(data=df,aes(x=Datetime, y=temp.max),colour="red", size=0.65,lty=2,alpha=1)+
#           scale_y_continuous(breaks=seq(0,30,3),labels=seq(0,30,3))+theme_bw()+
#           ylab(expression("Water Temperature (" * degree * "C)")) + xlab("") +
#           labs(title="Daily Mean/Max/Min Water Temps")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+
#           scale_x_datetime(breaks=date_breaks("1 month"),labels = date_format("%m-%y"))+
#           geom_line(data=df,aes(x=Datetime, y=temp.min),colour="navyblue", size=0.65,lty=2,alpha=1)
#         print(dplot+facet_grid(.~year,scales="free",drop=T))
#       }
#     }
#   })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$data, '.csv', sep='') },
    content = function(file) {
      write.csv(data(), file)
    }
  )
})  


