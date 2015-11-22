####
# sunspots Shiny App - ui.R
# Bob Hamilton, bobha@seanet.com
#

shinyUI(
	pageWithSidebar(
		headerPanel("Sunspots"),
		sidebarPanel(
			sliderInput("yearRange", "yearFrom/To window:", 
				min=minYear, max=maxYear, step=1, sep="", dragRange=TRUE, value=dfltYearRange),
			radioButtons("plotType", "raw dataset plotType:", 
				c(points="p", lines="l", steps="s"), inline=TRUE, selected=dfltPlotType),
			sliderInput("binSize", "smoothed dataset binSize (months):", 
				min=1, max=8 * 12 + 1, step=2, value=dfltBinSize),
			helpText(
				"Select a range of years from the monthly sunspot activity dataset.",
				"Drag either endpoint or drag the interval bar with your mouse.",
				"Next, smooth the dataset by specifying binSize,",
				"i.e. the number of datapoints included in the moving average."
			),
			actionButton("reset_input", "Reset")
		),
		mainPanel(
			plotOutput("tsPlot")
		)
	)
)

