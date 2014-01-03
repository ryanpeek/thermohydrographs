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
    h3("Data Input"),
    
    selectInput("sites","Sites",
                list("NF American" = "NFA", "MF American" = "MFA", "Rubicon" = "RUB", 
                     "NF Yuba" = "NFY", "SF Yuba" = "SFY")),
    selectInput("interval","Interval",
                list("Hourly" = "hourly", "Daily" = "daily", "7-day Avg" = "d7")),
    
#         h5("Months"),
#       sliderInput("mons","",1,12,c(4,8),step=1,format="#"),
           
    tags$hr(),
    
    downloadButton('downloadData', 'Download as csv'),
    tags$hr(),
    helpText('For the logger data, we can select variables to show in the table,
             sort variables, and customize the display of rows per page.')
        
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
