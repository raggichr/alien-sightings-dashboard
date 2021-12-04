#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dplyr)
library(plotly)
library(DT)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    data_select <- reactive({
        .GlobalEnv$ufo %>%
            filter(
                state == input$state,
                date.posted >= input$dates[1],
                date.posted <= input$dates[2]
            )
    })
    
    output$shapes <- plotly::renderPlotly({
        data_select() %>%
            ggplot(aes(.data$shape)) +
            geom_bar() +
            labs(
                x = "Shape",
                y = "# Sighted"
            )
    })
    
    output$duration_table <- DT::renderDT({
        data_select() %>%
            group_by(shape) %>%
            summarize(
                nb_sighted = n(),
                avg_duration_min = mean(duration_sec)/60,
                median_duration_min = median(duration_sec)/60,
                min_duration_min = min(duration_sec)/60,
                max_duration_min = max(duration_sec)/60
            )
    })
}
