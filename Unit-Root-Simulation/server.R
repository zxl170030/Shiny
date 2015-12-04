# Andy Philips
# aphilips@pols.tamu.edu
# 12/04/15
# --------------------------------#


library(shiny)


shinyServer(function(input, output) {

  output$plot <- renderPlot({
    y <- y.d <- y.t <- y.dt <- w <- rnorm(input$obs)
    theta0 <- 0.1
    T <- seq(1:input$obs)
    b <- 0.1
    for (t in 2:input$obs) y[t] <- y[t-1] + w[t]
    for (t in 2:input$obs) y.d[t] <- y.d[t-1] + theta0 + w[t]
    for (t in 2:input$obs) y.t[t] <- y.t[t-1] + b*T[t] + w[t]
    for (t in 2:input$obs) y.dt[t] <- y.dt[t-1] + theta0 + b*T[t] + w[t]
    plotType <- function(x, type) {
      switch(type,
             "Unit Root" = plot(y, type = "l", xlab = "Time", ylab = "Value", main = "Unit-Root", col = 'blue', lwd = 3),
             "With Drift" = plot(y.d, type = "l", xlab = "Time", ylab = "Value", main = "Unit-Root with Drift", col = 'blue', lwd = 3),
             "With Trend" = plot(y.t, type = "l", xlab = "Time", ylab = "Value", main = "Unit-Root with Deterministic Trend", col = 'blue', lwd = 3),
             "With Drift and Trend" = plot(y.dt, type = "l", xlab = "Time", ylab = "Value", main = "Unit-Root with Drift and Deterministic Trend", col = 'blue', lwd = 3))
    }

    plotType(y, input$pType)
  })
})