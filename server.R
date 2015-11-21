library(shiny)

data(sunspots)

shinyServer(
	function(input, output) {
		output$yearFrom <- renderPrint({input$yearRange[1]})
		output$yearTo <- renderPrint({input$yearRange[2]})
		output$plotType <- renderPrint({input$plotType})
		output$binSize <- renderPrint({input$binSize})

		output$tsPlot <- renderPlot({
			t1 <- input$yearRange[1]
			t2 <- input$yearRange[2] + 11/12
			pt <- input$plotType
			bs <- input$binSize

			y <- window(sunspots, start=t1, end=t2)
			y.sm <- window(filter(sunspots, rep(1, bs) / bs), start=t1, end=t2)

			plot(y, type=pt, xlab="year", ylab="sunspot count")
			lines(y.sm, col="red", lwd=2)
		})
	}
)
