library(shiny)
library(bslib)

library(tidyverse)


ui = page_sidebar(
  title = "Beta-Binomial Visualization",
  sidebar = sidebar(
    h4("Data:"),
    sliderInput(
      inputId = "x", label = "# of heads",
      min = 0, max = 50, value = 7
    ),
    sliderInput(
      inputId = "n", label = "# of flips",
      min = 0, max = 50, value = 10
    ),
    h4("Prior:"),
    numericInput(
      inputId = "a", label = "Prior # of heads",
      min = 0, max = 1000, value = 1
    ),
    numericInput(
      inputId = "b", label = "Prior # of tails",
      min = 0, max = 1000, value = 1
    )
  ),
  plotOutput(outputId = "plot"),
  tableOutput(outputId = "table")
)

server = function(input, output, session) {
  
  observe({
    updateSliderInput(
      session, inputId = "x", max = input$n
    )
  })
  
  d = reactive({
    
    validate(
      need(input$x <= input$n, "Number of heads needs to be less than or equal to the number of flips!"),
      need(input$a >= 0 & input$b >= 0, "Prior hyperparameters need to be >= 0")
    )
    
    
    df = tibble(
      p = seq(0,1, length.out = 1001)
    ) |>
      mutate(
        prior = dbeta(p, shape1 = input$a, shape2 = input$b),
        likelihood = dbinom(input$x, size = input$n, prob = p) |>
          (\(x) {x / (sum(x) / n())})(),
        posterior = dbeta(
          p, shape1 = input$a +input$x, shape2 = input$b + input$n - input$x
        )
      ) |>
      pivot_longer(
        cols = -p,
        names_to = "distribution",
        values_to = "density"
      ) 
    
    print(df)
    
    df
  })
  
  
  output$table = renderTable({
    d() |>
      group_by(distribution) |>
      summarize(
        mean = sum(p * density) / n(),
        median = p[cumsum(density/n()) >= 0.5][1],
        q025 = p[cumsum(density/n()) >= 0.025][1],
        q975 = p[cumsum(density/n()) >= 0.975][1]
      )
  })
  
  output$plot = renderPlot({
    d() |>
      ggplot(
        aes(x=p, y=density, color=distribution)
      ) +
      geom_line()
  })
  
}

shinyApp(ui = ui, server = server)


