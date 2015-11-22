####
# sunspots Shiny App - server.R
# Bob Hamilton, bobha@seanet.com
#

library(shiny)

library(datasets)
data(sunspot.month)
ss <- sunspot.month				## choose sunspots or sunspot.month

minYear <- ceiling(tsp(ss)[1])		## first full year
maxYear <- floor(tsp(ss)[2] - 11/12)	## last full year

## condition default values
dfltYearRange <- c(1800, 1899)
dfltPlotType <- "p"
dfltBinSize <- 25


shinyServer(
	function(input, output, session) {
		## reset button
		observeEvent(input$reset_input, {
			updateSliderInput(session, "yearRange", value=dfltYearRange)
			updateRadioButtons(session, "plotType", selected=dfltPlotType)
			updateSliderInput(session, "binSize", value=dfltBinSize)
		})

		## time-series plot
		output$tsPlot <- renderPlot({
			t1 <- input$yearRange[1]
			t2 <- input$yearRange[2] + 11/12
			pt <- input$plotType
			bs <- input$binSize

			y <- window(ss, start=t1, end=t2)
			y.sm <- window(filter(ss, rep(1, bs) / bs), start=t1, end=t2)

			title <- sprintf("%d years of sunspot activity, %d-%d", 
				as.integer(t2 - t1 + 1), as.integer(t1), as.integer(t2))

			plot(y, type=pt, cex=0.5, xlab="year", ylab="sunspot count", main=title)
			lines(y.sm, col="red", lwd=2)
		})
	}
)
