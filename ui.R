library(shiny)

pageWithSidebar(
	headerPanel("Sunspots"),
	sidebarPanel(
		sliderInput("yearRange", "yearFrom/To:", value = c(1944, 1976), min = 1749, max = 1984, step = 1, sep="", dragRange=TRUE),
		radioButtons("plotType", "plotType:", c(points="p", lines="l", steps="s"), inline=TRUE),
		sliderInput("binSize", "binSize (months):", value = 25, min = 1, max = 8 * 12 + 1, step = 2)
	),
	mainPanel(
		h4("yearFrom:"), verbatimTextOutput("yearFrom"),
		h4("yearTo:"), verbatimTextOutput("yearTo"),
		h4("plotType:"), verbatimTextOutput("plotType"),
		h4("binSize:"), verbatimTextOutput("binSize"),
		plotOutput("tsPlot")
	)
)
