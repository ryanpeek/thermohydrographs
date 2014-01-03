function(){
	tabPanel("About",
		p(style="text-align:justify",'This web application uses data collected by the Center for Watershed Sciences at UC Davis
    as part of long-term Sierra Nevada River monitoring initiated by a California Energy Comission Project. Solinst pressure transducer 
    deployed in 5 rivers have been logging data at 15 min intervals for the last 3 years. Collection of observed data through 
    monitoring is a vital tool for assessing change in aquatic ecosystems, particularly in relation to climate warming and river
    regulation. This app illustrates a few useful ways to summarize and plot these data. 
    Thermohydrographs are a way to show both stage (level) and water temperature on a single plot. Depending on river and interval
    selected, data can be downloaded as CSV files. '),
		br(),

		#HTML('<div style="clear: left;"><img src="https://watershed.ucdavis.edu/files/cwsheader_0.png" style="float: left; margin-right:5px; height=20%;"/></div>'),
		strong('Author'),
		p('Ryan Peek',br(),
			'Aquatic Ecologist',br(),
			a('Center for Watershed Sciences', href="http://watershed.ucdavis.edu/", target="_blank")
		),
		br(),

		div(class="row-fluid",
# 			div(class="span4",strong('Related apps'),
# 				p(HTML('<ul>'),
# 					HTML('<li>'),a("Coastal Alaska Extreme Temperature and Wind Events", href="http://shiny.snap.uaf.edu/temp_wind_events/", target="_blank"),HTML('</li>'),
# 					HTML('<li>'),a("Arctic Sea Ice Extents and Concentrations", href="http://shiny.snap.uaf.edu/sea_ice_coverage/", target="_blank"),HTML('</li>'),
# 				HTML('</ul>')),
# 				strong('Code'),
# 				p('Source code available at',
# 				a('GitHub', href="https://github.com/ua-snap/shiny-apps/tree/devel/ak_station_cru_eda", target="_blank")),
# 				br()
# 			),
#         
# 			div(class="span4", strong('Related blog posts'),
# 				p(HTML('<ul>'),
# 					HTML('<li>'),a("R Shiny web app: Alaska climate data EDA", href="http://blog.snap.uaf.edu/2013/05/20/r-shiny-web-app-alaska-climate-data-eda/", target="_blank"),HTML('</li>'),
# 					HTML('<li>'),a("R Shiny web app: Coastal Alaska extreme temperature and wind events", href="http://blog.snap.uaf.edu/2013/05/20/r-shiny-web-app-extreme-events/", target="_blank"),HTML('</li>'),
# 					HTML('<li>'),a("R Shiny web app: Arctic sea ice extents and concentrations", href="http://blog.snap.uaf.edu/2013/05/20/r-shiny-web-app-sea-ice/", target="_blank"),HTML('</li>'),
# 				HTML('</ul>')),
# 				br()
# 			),
			div(class="span4",
				strong('References'),
				p(HTML('<ul>'),
				  HTML('<li>'),a('Management of the Spring Recession Project', href="https://watershed.ucdavis.edu/project/recession", target="_blank"),HTML('</li>'),
          HTML('<ul>'), 
          HTML('<li>'),a('Report', href="https://watershed.ucdavis.edu/library/management-spring-snowmelt-recession", target="_blank"),HTML('</li>'),
				  HTML('</ul>'),
          HTML('<li>'),strong("Additional resources"),HTML('</li>'),
					HTML('<ul>'),
				  HTML('<li>'),a('Coded in R', href="http://www.r-project.org/", target="_blank"),HTML('</li>'),
				  HTML('<li>'),a('Built with the Shiny package', href="http://www.rstudio.com/shiny/", target="_blank"),HTML('</li>'),
				  HTML('<li>'),a('Matthew Leonawicz (has some great shiny app examples)', href="http://www.snap.uaf.edu/", target="_blank"),HTML('</li>'),
					HTML('<li>'),a('ggplot2', href="http://cran.r-project.org/web/packages/ggplot2/index.html", target="_blank"),HTML('</li>'),
				  HTML('</ul>'))
      )
		)
	)
}