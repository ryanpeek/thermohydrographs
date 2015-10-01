function(){
	tabPanel("About",
		p(style="text-align:justify",'This web application uses data collected by the Center for Watershed Sciences at UC Davis
    as part of a Long-term River Monitoring Project, building on a previous California Energy Comission Project. Solinst pressure transducers 
    have been deployed (since 2011) in 5 rivers and are logging water temperature and stage at 15 min intervals. Collection of observed data through 
    monitoring is a vital tool for assessing change in aquatic ecosystems, particularly in relation to climate warming and river
    regulation. This app illustrates a few useful ways to summarize and plot these data. 
    Thermohydrographs are a way to show both stage (level) and water temperature on a single plot. Depending on river and interval
    selected, data can be downloaded as CSV files. '),
		br(),

		#HTML('<div style="clear: left;"><img src="https://watershed.ucdavis.edu/files/cwsheader_0.png" style="float: left; margin-right:5px; height=20%;"/></div>'),
		strong('Author'),
		p('Ryan Peek',br(),
			'Aquatic Ecologist',br(),
			a('Center for Watershed Sciences', href="http://watershed.ucdavis.edu/", target="_blank"),
			img(src="CWS.png",height=72,width=72)
		),
		br(),

		div(class="span4",
        strong('Code'),
        p('Source code available:',
          a("Here", href="https://github.com/ryan-ucd/thermohydrographs",target="_blank")),
        br()
      ),

    div(class="span4",
				strong('References'),
				p(HTML('<ul>'),
				  HTML('<li>'),a('Long-term River Monitoring Project', href="https://watershed.ucdavis.edu/project/long-term-river-monitoring", target="_blank"),HTML('</li>'),
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
}