shinyUI(fluidPage(
  #Application title
  titlePanel("So are you a good Scrabbler?"),
  sidebarPanel(
    p("Scrabble is a word game that involves an element of chance."),
    p("Picking any of the ten tiles below will affect how high you can score in a game."),
    p("Data from 400 matches involving top Singapore and Malaysia players can provide prediction of a benchmark score on how well you should score given good/bad luck."),
    p("(Histogram of the scores to the right)"),
    br(),
    br(),
    h4("Choose the tiles you picked in your last game, and see if your score match up to the target score!"),
    checkboxGroupInput("Hi", label=h5("Did you pick any of these high-scoring tiles?"),
                       choices=list("J" = "j", "Q" = "q", "X" = "x", "Z" = "z")),
    numericInput("blank", label=h5("Number of blanks you picked (0 to 2)"), 0, min=0, max=2, step=1),
    numericInput("s", label=h5("Number of S's you picked (0 to 4)"), 0, min=0, max=4, step=1),
    submitButton('Submit')
  ),
  mainPanel(
    plotOutput("scoreHist"),
    br(),
    h3(textOutput("scorePred"))
  )
))