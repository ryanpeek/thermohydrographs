tabPanel("About",
         HTML(
           '<p style="text-align:justify">This web application uses data collected by the Center for Watershed Sciences at UC Davis
    as part of a Long-term River Monitoring Project, building on a previous California Energy Comission Project. Solinst pressure transducers 
           have been deployed (since 2011) in 5 rivers and are logging water temperature and stage at 15 min intervals. Collection of observed data through 
           monitoring is a vital tool for assessing change in aquatic ecosystems, particularly in relation to climate warming and river
           regulation. This app illustrates a few useful ways to summarize and plot these data. 
           Thermohydrographs are a way to show both stage (level) and water temperature on a single plot. Depending on river and interval
           selected, data can be downloaded as CSV files. </p>'),
         
         HTML('
              <div style="clear: left;"><img src="https://watershed.ucdavis.edu/files/styles/medium/public/images/users/RyanPeek1.JPG?itok=uJfL4TVh" alt="" style="float: left; margin-right:5px" /></div>
              <p>Ryan Peek<br/>
              Aquatic Ecologist at Center for Watershed Sciences |  PhD Candidate in Ecology, UC Davis<br/>
              <a href="https://twitter.com/riverpeek" target="_blank">Twitter</a> | 
              <a href="http://watershed.ucdavis.edu/", target="_blank">Center for Watershed Sciences</a> |
              <a href="http://ryanpeek.github.io" target="_blank">Website</a> |
              </p>'),
         

         fluidRow(
           column(4,
                  HTML('<strong>Source Code on Github</strong>
                      <p><a href="https://github.com/ryan-ucd/thermohydrographs",target="_blank">thermohydrographs</a></p>
                      <ul>
                      <li><a href="https://watershed.ucdavis.edu/project/long-term-river-monitoring", target="_blank">Long-term River Monitoring Project</a></li>
                      <li><a href="https://watershed.ucdavis.edu/project/recession", target="_blank">Management of the Spring Recession Project</a></li>
                      </ul>')
           )
         ),


         fluidRow(
           column(4,
                  HTML('<strong>References</strong>
                       <p></p><ul>
                       <li><a href="http://www.r-project.org/" target="_blank">Coded in R</a></li>
                       <li><a href="http://www.rstudio.com/shiny/" target="_blank">Built with the Shiny package</a></li>
                       <li>Additional supporting R packages</li>
                       <ul>
                       <li><a href="http://rstudio.github.io/shinythemes/" target="_blank">shinythemes</a></li>
                       <li><a href="https://github.com/ebailey78/shinyBS" target="_blank">shinyBS</a></li>
                       <li><a href="http://rstudio.github.io/leaflet/" target="_blank">leaflet</a></li>
                       </ul>')
           )
         ),
         value="about"
)