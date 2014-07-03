## To run locally:
library(shiny)
runApp(appDir= "C:/Users/rapeek/Dropbox/R/PROJECTS/thermohydrographs")

## To run online:
devtools::install_github('rstudio/shinyapps')
library(shinyapps)
shinyapps::setAccountInfo(name="aquapeek", token="454252EE1B63A5BF6F3FD7387CF18FD5", secret="Q6V9YH7ApqkGIXwQYfwK8WfDCAJCbwP+a8JYdoUS")

## if you've created your own project for the app, makes it easier to run
runApp()

## or with
deployApp()

## for large apps need to start default with more memory:

Instance Type   Memory
small 			 256 MB		(default)
medium			 512 MB
large			 1024 MB
xlarge			 2048 MB
xxlarge			 4096 MB

shinyapps::configureApp(APPNAME, size="medium")