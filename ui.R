#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinythemes)
library(plotly)
library(DT)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("UFO Sightings"),
    
    # Adding a theme
    # shinythemes::themeSelector(),
    theme = shinythemes::shinytheme("darkly"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("state", "Choose a U.S. state:", choices = unique(.GlobalEnv$ufo$state)),
            dateRangeInput("dates", "Choose a date range:",
                           start = .GlobalEnv$ufo$date.posted[1],
                           end = .GlobalEnv$ufo$date.posted[length(.GlobalEnv$ufo$date.posted)]
            )
        ),
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", plotly::plotlyOutput("shapes")),
                tabPanel("Table", DT::DTOutput("duration_table"))
            )
        )
    )
)

# Run the application 
# shinyApp(ui = ui, server = server)
