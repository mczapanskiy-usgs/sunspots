library(shiny)

data(sunspots)
dfltYearRange <- c(1800, 1899)
dfltPlotType <- "p"
dfltBinSize <- 25

shinyServer(
	function(input, output, session) {
		observeEvent(input$reset_input, {
			updateSliderInput(session, "yearRange", value=dfltYearRange)
			updateRadioButtons(session, "plotType", selected=dfltPlotType)
			updateSliderInput(session, "binSize", value=dfltBinSize)
		})

		output$tsPlot <- renderPlot({
			t1 <- input$yearRange[1]
			t2 <- input$yearRange[2] + 11/12
			pt <- input$plotType
			bs <- input$binSize

			y <- suppressWarnings(window(sunspots, start=t1, end=t2))
			y.sm <- window(filter(sunspots, rep(1, bs) / bs), start=t1, end=t2)

			plot(y, type=pt, xlab="year", ylab="sunspot count")
			lines(y.sm, col="red", lwd=2)
		})
	}
)
