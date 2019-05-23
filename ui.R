library(shiny)
library(leaflet)
tabPanelAbout <- source("about.r")$value
headerPanel_2 <- function(title, h, windowTitle=title) {    
  tagList(
    tags$head(tags$title(windowTitle)),
    h(title)
  )
}

shinyUI(fluidPage(
  
  headerPanel_2(
    HTML(
      '<div id="stats_header">
			River Thermohydrographs
			<a href="http://watershed.ucdavis.edu" target="_blank">
      <left>
			<img id="cws_logo" alt="CWS Logo" src="https://watershed.ucdavis.edu/files/cwsheader_0.png" />
			</left>
      </a>
			</div>'
    ), h3, "River Thermohydrographs"),
  
  # Sidebar with file input option and checkbox for header
  sidebarPanel(
    
    h4("Select a River & Logging Interval: "),
    
    selectInput("sites","Sites",
                list("NF American (unreg)" = "NFA", 
                     "MF American (reg)" = "MFA", "Rubicon (reg)" = "RUB", 
                     "NF Yuba (unreg)" = "NFY", "SF Yuba (reg)" = "SFY", 
                     "Clavey (unreg)" = "CLA", "Tuolumne at Clavey (reg)"= "TUO")),
    selectInput("interval","Logging Interval",
                list("Hourly" = "hourly", 
                     "Daily" = "daily", 
                     "7-day Avg" = "d7")),
    
    h6("Select year(s):"),

    checkboxGroupInput(inputId="years","Available Years",
                       choices=c(2011,2012,2013,
                                 2014,2015,2016,2017,2018),selected=c(2014,2017)),

    tags$hr(),
    
    downloadButton('downloadData', 'Download as csv'),
    tags$hr(),
    helpText('These plots represent stage (y-axis) and water temperature (color). 
              Regulated ("reg") sites are reaches with hydropower flows, unregulated ("unreg")
              represent "natural" flow conditions in the Sierra Nevada. Click on other tabs to view summary data
              and more about our monitoring/research.'),
    tags$hr(),
    helpText('Data updated 05/15/2017')
      
  ),

  
  # This is the actual output panel
  mainPanel(
    h4(textOutput("caption")),
    tabsetPanel(
      tabPanel("Plots", plotOutput("plot"), plotOutput("plot2"),plotOutput("plot3")),
      tabPanel("Data Summary", verbatimTextOutput("summary"),dataTableOutput("mytable1")), 
      tabPanel(
        "Monitoring Locations",leafletOutput("map"),
        h5("Long Term River Monitoring Locations")
      ),
      tabPanelAbout()
    )
  )
))
