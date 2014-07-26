library(shiny)
tabPanelAbout <- source("about.r")$value
headerPanel_2 <- function(title, h, windowTitle=title) {    
  tagList(
    tags$head(tags$title(windowTitle)),
    h(title)
  )
}

shinyUI(pageWithSidebar(
  
  headerPanel_2(
    HTML(
      '<div id="stats_header">
			River Thermohydrographs
			<a href="http://watershed.ucdavis.edu" target="_blank">
      <center>
			<img id="cws_logo" alt="CWS Logo" src="https://watershed.ucdavis.edu/files/cwsheader_0.png" />
			</center>
      </a>
			</div>'
    ), h3, "River Thermohydrographs"),
  
  # Sidebar with file input option and checkbox for header
  sidebarPanel(
    h4("Select a River and Logging Interval: "),
    
    selectInput("sites","Sites",
                list("NF American (unreg)" = "NFA", "MF American (reg)" = "MFA", "Rubicon (reg)" = "RUB", 
                     "NF Yuba (unreg)" = "NFY", "SF Yuba (reg)" = "SFY", "Clavey (unreg)" = "CLA", 
                     "Tuolumne at Clavey (reg)"= "TUO")),
    selectInput("interval","Logging Interval",
                list("Hourly" = "hourly", "Daily" = "daily", "7-day Avg" = "d7")),
    
    h6("Select year(s):"),

    checkboxGroupInput(inputId="years","Available Years",choices=c(2011,2012,2013,2014),selected=c(2011,2012,2013,2014)),
           
    tags$hr(),
    
    downloadButton('downloadData', 'Download as csv'),
    tags$hr(),
    helpText('These plots represent stage (y-axis) and water temperature (color). 
              Regulated ("reg") sites are reaches with hydropower flows, unregulated ("unreg")
              represent "natural" flow conditions in the Sierra Nevada. Click on other tabs to view summary data
              and more about our monitoring/research.')
        
  ),

  
  # This is the actual output panel
  mainPanel(
    h3(textOutput("caption")),
    tabsetPanel(
      tabPanel("Plots", plotOutput("plot"), plotOutput("plot2"),plotOutput("plot3")),
      tabPanel("Summary", verbatimTextOutput("summary"),verbatimTextOutput("struct")), 
      tabPanel("Datatable",dataTableOutput("mytable1")),
      tabPanelAbout()
    )
  )
))
