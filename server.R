library(shiny)
library(randomForest)
scrab.stat <- read.csv("CSC game stats.csv")
set.seed(1707)
training <- scrab.stat[, c(3, 13:18)]
modFit <- randomForest(score ~., data=training)
scoreHist <- hist(scrab.stat$score)

shinyServer(
  function (input, output) {
    stats <- reactive({data.frame(blank=input$blank,
                                  j=("j" %in% input$Hi)*1,
                                  q=("q" %in% input$Hi)*1,
                                  x=("x" %in% input$Hi)*1,
                                  z=("z" %in% input$Hi)*1,
                                  s=input$s)
    })
    scorePred <- reactive({round(predict(modFit, stats()))
    })
    output$scorePred <- renderText({
      paste("Your target score is:", scorePred())
    })
    output$scoreHist <- renderPlot({
      plot(scoreHist, xlab="Score", main="Histogram of Scrabble Scores",
           sub="based on 400 games of Top Singapore and Malaysia players")
      lines(c(scorePred(), scorePred()), c(0, 200), col="red", lwd=5)
    })
  }  
)