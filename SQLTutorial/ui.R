library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
  dashboardHeader(title = "SQL Tutorial: Agricultural Database"),
  
  dashboardSidebar(
    # Logo at the top
    div(style = "padding: 20px; text-align: center; background-color: #222d32;",
        img(src = "SIAPNEW_logo_2020_1800.png", width = "80%", alt = "SQL Tutorial Logo")
    ),
    
    sidebarMenu(id = "sidebar",
                menuItem("Introduction", tabName = "intro", icon = icon("home")),
                menuItem("Lesson 1: SELECT", tabName = "lesson1", icon = icon("1")),
                menuItem("Lesson 2: WHERE", tabName = "lesson2", icon = icon("2")),
                menuItem("Lesson 3: Aggregates", tabName = "lesson3", icon = icon("3")),
                menuItem("Lesson 4: GROUP BY", tabName = "lesson4", icon = icon("4")),
                menuItem("Lesson 5: JOINs", tabName = "lesson5", icon = icon("5")),
                menuItem("Lesson 6: ORDER/LIMIT", tabName = "lesson6", icon = icon("6")),
                menuItem("Challenge", tabName = "challenge", icon = icon("trophy"))
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .exercise-box {
          background-color: #f8f9fa;
          padding: 15px;
          border-radius: 5px;
          margin-bottom: 20px;
          border: 1px solid #dee2e6;
        }
        .sql-input {
          font-family: 'Courier New', monospace;
          font-size: 14px;
        }
        .success-msg {
          color: #28a745;
          font-weight: bold;
          padding: 10px;
          background-color: #d4edda;
          border-left: 4px solid #28a745;
          margin-top: 10px;
        }
        .error-msg {
          color: #dc3545;
          font-weight: bold;
          padding: 10px;
          background-color: #f8d7da;
          border-left: 4px solid #dc3545;
          margin-top: 10px;
        }
        .hint-box {
          background-color: #fff3cd;
          padding: 10px;
          border-left: 4px solid #ffc107;
          margin-top: 10px;
        }
        .concept-box {
          background-color: #e7f3ff;
          padding: 15px;
          border-radius: 5px;
          margin: 20px 0;
          border-left: 4px solid #0066cc;
        }
        .concept-box h4 {
          color: #0066cc;
          margin-top: 0;
        }
        .btn-run {
          font-weight: bold;
        }
        .btn-check {
          background-color: #6c757d !important;
          border-color: #6c757d !important;
          color: white !important;
        }
        .btn-check:hover {
          background-color: #5a6268 !important;
          border-color: #545b62 !important;
        }
        .btn-hint {
          background-color: #6c757d !important;
          border-color: #6c757d !important;
          color: white !important;
        }
        .btn-hint:hover {
          background-color: #5a6268 !important;
          border-color: #545b62 !important;
        }
      "))
    ),
    
    tabItems(
      # Introduction tab
      tabItem(tabName = "intro",
              h2("Introduction to SQL: Agricultural Database"),
              box(width = 12,
                  h3("Welcome!"),
                  p("In this tutorial, you'll learn how to query data from a database containing information about:"),
                  tags$ul(
                    tags$li(strong("Regions:"), " Geographic areas with population data"),
                    tags$li(strong("Farms:"), " Agricultural exploitations in different regions"),
                    tags$li(strong("Crops:"), " Different types of crops grown"),
                    tags$li(strong("Production:"), " Harvest data including yields and quantities")
                  ),
                  h4("Database Structure"),
                  p("The database has 4 tables:"),
                  tags$ol(
                    tags$li(code("regions"), " - Information about geographic regions (region_id, region_name, area_km2, population)"),
                    tags$li(code("farms"), " - Details about agricultural farms (farm_id, farm_name, region_id, year_established, area_hectares, farm_type)"),
                    tags$li(code("crops"), " - Types of crops available (crop_id, crop_name, category, cycle_days)"),
                    tags$li(code("production"), " - Production records linking farms and crops (production_id, farm_id, crop_id, year, area_cultivated, quantity_tonnes, yield_tonne_ha)")
                  ),
                  hr(),
                  h4("How to Use This Tutorial"),
                  tags$ol(
                    tags$li("Navigate through the lessons using the sidebar menu"),
                    tags$li("Read the concept explanations before each exercise"),
                    tags$li("Write your SQL queries in the text boxes (", strong("pure SQL, no R code needed"), ")"),
                    tags$li("Click ", strong("'Run Query'"), " to execute your query and see results"),
                    tags$li("Click 'Check Answer' to verify if your solution is correct"),
                    tags$li("Use 'Show Hint' if you need help"),
                    tags$li("Use 'Show Solution' to see the correct answer")
                  ),
                  br(),
                  actionButton("start_lesson1", "Start Lesson 1", icon = icon("play"), class = "btn-success btn-lg")
              )
      ),
      
      # Lesson tabs
      tabItem(tabName = "lesson1",
              h2("Lesson 1: SELECT Basics"),
              uiOutput("lesson1_exercises")
      ),
      
      tabItem(tabName = "lesson2",
              h2("Lesson 2: WHERE Clause - Filtering Data"),
              uiOutput("lesson2_exercises")
      ),
      
      tabItem(tabName = "lesson3",
              h2("Lesson 3: Aggregate Functions"),
              uiOutput("lesson3_exercises")
      ),
      
      tabItem(tabName = "lesson4",
              h2("Lesson 4: GROUP BY"),
              uiOutput("lesson4_exercises")
      ),
      
      tabItem(tabName = "lesson5",
              h2("Lesson 5: JOIN Operations"),
              uiOutput("lesson5_exercises")
      ),
      
      tabItem(tabName = "lesson6",
              h2("Lesson 6: ORDER BY and LIMIT"),
              uiOutput("lesson6_exercises")
      ),
      
      tabItem(tabName = "challenge",
              h2("Challenge: Complex Query"),
              uiOutput("challenge_exercises")
      )
    )
  )
)