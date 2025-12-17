library(shiny)
library(DBI)
library(RMySQL)
library(DT)


# Create database connection
con <- dbConnect(
  RMySQL::MySQL(),
  host = "sql12.freesqldatabase.com",
  user = "sql12811352",
  password = "sZ2PBZBjEd",
  dbname = "sql12811352",
  port = 3306
)

# Lesson content with concepts
lesson_content <- list(
  lesson1 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("book"), " Understanding SELECT"),
          p(strong("SELECT"), " is the most fundamental SQL command. It retrieves data from a database table."),
          p(strong("Basic syntax:"), code("SELECT column1, column2 FROM table_name;")),
          tags$ul(
            tags$li(code("SELECT *"), " - Select all columns from a table"),
            tags$li(code("SELECT column1, column2"), " - Select specific columns"),
            tags$li("Always end SQL statements with a semicolon (", code(";"), ")")
          ),
          p(strong("Example:"), code("SELECT region_name, population FROM regions;"))
      )
    )
  ),
  
  lesson2 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("filter"), " Filtering Data with WHERE"),
          p(strong("WHERE"), " clause filters rows based on specified conditions."),
          p(strong("Basic syntax:"), code("SELECT columns FROM table WHERE condition;")),
          tags$ul(
            tags$li(strong("Comparison operators:"), code(">"), ", ", code("<"), ", ", code(">="), ", ", code("<="), ", ", code("="), ", ", code("!=")),
            tags$li(strong("Text values:"), " Use single quotes: ", code("WHERE farm_type = 'Organic'")),
            tags$li(strong("Numbers:"), " No quotes needed: ", code("WHERE region_id = 1")),
            tags$li(strong("Logical operators:"), code("AND"), ", ", code("OR"), ", ", code("NOT"))
          ),
          p(strong("Example:"), code("SELECT * FROM farms WHERE area_hectares > 100 AND year_established > 2000;"))
      )
    )
  ),
  
  lesson3 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("calculator"), " Aggregate Functions"),
          p(strong("Aggregate functions"), " perform calculations on sets of values and return a single value."),
          p(strong("Common aggregate functions:")),
          tags$ul(
            tags$li(code("COUNT(*)"), " - Count the number of rows"),
            tags$li(code("SUM(column)"), " - Calculate the total sum of a column"),
            tags$li(code("AVG(column)"), " - Calculate the average value"),
            tags$li(code("MAX(column)"), " - Find the maximum value"),
            tags$li(code("MIN(column)"), " - Find the minimum value")
          ),
          p(strong("Using aliases:"), " Give your results meaningful names with ", code("AS"), ":"),
          p(code("SELECT COUNT(*) AS total_farms FROM farms;"))
      )
    )
  ),
  
  lesson4 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("layer-group"), " Grouping Data with GROUP BY"),
          p(strong("GROUP BY"), " groups rows that have the same values in specified columns."),
          p("It's typically used with aggregate functions to perform calculations on each group."),
          p(strong("Basic syntax:"), code("SELECT column, AGG_FUNCTION(column2) FROM table GROUP BY column;")),
          tags$ul(
            tags$li("The column in ", code("SELECT"), " must either be in ", code("GROUP BY"), " or used in an aggregate function"),
            tags$li("You can group by multiple columns: ", code("GROUP BY column1, column2"))
          ),
          p(strong("Example:"), code("SELECT farm_type, COUNT(*) as count FROM farms GROUP BY farm_type;")),
          p("This counts how many farms exist for each farm type.")
      )
    )
  ),
  
  lesson5 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("link"), " Joining Tables with JOIN"),
          p(strong("JOIN"), " combines rows from two or more tables based on a related column."),
          p(strong("Basic syntax:"), code("SELECT columns FROM table1 JOIN table2 ON table1.column = table2.column;")),
          tags$ul(
            tags$li(strong("INNER JOIN (or just JOIN):"), " Returns matching rows from both tables"),
            tags$li(strong("LEFT JOIN:"), " Returns all rows from left table, matching rows from right"),
            tags$li(strong("Foreign keys:"), " Columns that reference primary keys in other tables")
          ),
          p(strong("Example - joining two tables:")),
          p(code("SELECT farms.farm_name, regions.region_name FROM farms JOIN regions ON farms.region_id = regions.region_id;")),
          p(strong("Multiple joins:"), " You can chain multiple JOINs to connect 3+ tables:"),
          p(code("SELECT ... FROM table1 JOIN table2 ON ... JOIN table3 ON ...;"))
      )
    )
  ),
  
  lesson6 = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("sort"), " Sorting and Limiting Results"),
          p(strong("ORDER BY"), " sorts the result set by one or more columns."),
          tags$ul(
            tags$li(code("ORDER BY column ASC"), " - Ascending order (default)"),
            tags$li(code("ORDER BY column DESC"), " - Descending order"),
            tags$li("You can sort by multiple columns: ", code("ORDER BY column1 DESC, column2 ASC"))
          ),
          p(strong("LIMIT"), " restricts the number of rows returned."),
          tags$ul(
            tags$li(code("LIMIT 5"), " - Returns only the first 5 rows"),
            tags$li("Often combined with ", code("ORDER BY"), " to get 'top N' results")
          ),
          p(strong("Example - Top 5 largest farms:")),
          p(code("SELECT farm_name, area_hectares FROM farms ORDER BY area_hectares DESC LIMIT 5;"))
      )
    )
  ),
  
  challenge = list(
    concepts = list(
      div(class = "concept-box",
          h4(icon("trophy"), " Putting It All Together"),
          p("The challenge requires combining multiple SQL concepts you've learned:"),
          tags$ul(
            tags$li(strong("JOIN:"), " Connect multiple tables"),
            tags$li(strong("Aggregate functions:"), " Calculate totals and averages"),
            tags$li(strong("GROUP BY:"), " Group data by categories"),
            tags$li(strong("ORDER BY:"), " Sort results"),
            tags$li(strong("LIMIT:"), " Restrict output to top results")
          ),
          p("Think step by step:"),
          tags$ol(
            tags$li("Which tables do I need?"),
            tags$li("How are they related (JOIN conditions)?"),
            tags$li("What calculations do I need (aggregate functions)?"),
            tags$li("How should I group the data?"),
            tags$li("How should I sort and limit the results?")
          )
      )
    )
  )
)

# Exercise definitions
exercises <- list(
  # Lesson 1: SELECT Basics
  list(
    id = "ex1_1",
    lesson = "Lesson 1: SELECT Basics",
    title = "Exercise 1.1: View All Regions",
    description = "Write a query to display all columns from the regions table.",
    hint = "Use SELECT * FROM table_name;",
    solution = "SELECT * FROM regions;",
    check_type = "exact"
  ),
  list(
    id = "ex1_2",
    lesson = "Lesson 1: SELECT Basics",
    title = "Exercise 1.2: Select Specific Columns",
    description = "Display only the region_name and population columns from the regions table.",
    hint = "Use SELECT column1, column2 FROM table_name;",
    solution = "SELECT region_name, population FROM regions;",
    check_type = "exact"
  ),
  list(
    id = "ex1_3",
    lesson = "Lesson 1: SELECT Basics",
    title = "Exercise 1.3: View All Crops",
    description = "Write a query to display all information about crops.",
    hint = "Use SELECT * FROM crops;",
    solution = "SELECT * FROM crops;",
    check_type = "exact"
  ),
  
  # Lesson 2: WHERE Clause
  list(
    id = "ex2_1",
    lesson = "Lesson 2: WHERE Clause",
    title = "Exercise 2.1: Filter by Region",
    description = "Display all farms located in the 'North' region (region_id = 1).",
    hint = "Use WHERE to filter rows: WHERE column_name = value",
    solution = "SELECT * FROM farms WHERE region_id = 1;",
    check_type = "exact"
  ),
  list(
    id = "ex2_2",
    lesson = "Lesson 2: WHERE Clause",
    title = "Exercise 2.2: Filter by Farm Type",
    description = "Show all farms where the farm_type is 'Organic'.",
    hint = "Use quotes for text values: WHERE farm_type = 'Organic'",
    solution = "SELECT * FROM farms WHERE farm_type = 'Organic';",
    check_type = "exact"
  ),
  list(
    id = "ex2_3",
    lesson = "Lesson 2: WHERE Clause",
    title = "Exercise 2.3: Numeric Comparison",
    description = "Find all farms with an area greater than 150 hectares.",
    hint = "Use comparison operators: >, <, >=, <=, =",
    solution = "SELECT * FROM farms WHERE area_hectares > 150;",
    check_type = "exact"
  ),
  list(
    id = "ex2_4",
    lesson = "Lesson 2: WHERE Clause",
    title = "Exercise 2.4: Multiple Conditions",
    description = "Find all farms established after 2000 AND with more than 100 hectares.",
    hint = "Use AND to combine conditions",
    solution = "SELECT * FROM farms WHERE year_established > 2000 AND area_hectares > 100;",
    check_type = "exact"
  ),
  
  # Lesson 3: Aggregate Functions
  list(
    id = "ex3_1",
    lesson = "Lesson 3: Aggregate Functions",
    title = "Exercise 3.1: COUNT Function",
    description = "Count how many farms exist in the database.",
    hint = "Use COUNT(*) to count all rows",
    solution = "SELECT COUNT(*) as total_farms FROM farms;",
    check_type = "exact"
  ),
  list(
    id = "ex3_2",
    lesson = "Lesson 3: Aggregate Functions",
    title = "Exercise 3.2: Average Area",
    description = "Calculate the average area (in hectares) of all farms.",
    hint = "Use the AVG() function",
    solution = "SELECT AVG(area_hectares) as average_area FROM farms;",
    check_type = "exact"
  ),
  list(
    id = "ex3_3",
    lesson = "Lesson 3: Aggregate Functions",
    title = "Exercise 3.3: Maximum Population",
    description = "Find the maximum population among all regions.",
    hint = "Use the MAX() function",
    solution = "SELECT MAX(population) as max_population FROM regions;",
    check_type = "exact"
  ),
  list(
    id = "ex3_4",
    lesson = "Lesson 3: Aggregate Functions",
    title = "Exercise 3.4: Sum of Production",
    description = "Calculate the total quantity of all production (in tonnes) for the year 2023.",
    hint = "Combine SUM() with a WHERE clause",
    solution = "SELECT SUM(quantity_tonnes) as total_production FROM production WHERE year = 2023;",
    check_type = "exact"
  ),
  
  # Lesson 4: GROUP BY
  list(
    id = "ex4_1",
    lesson = "Lesson 4: GROUP BY",
    title = "Exercise 4.1: Count Farms by Type",
    description = "Count how many farms exist for each farm type.",
    hint = "Use GROUP BY with COUNT(*)",
    solution = "SELECT farm_type, COUNT(*) as farm_count FROM farms GROUP BY farm_type;",
    check_type = "exact"
  ),
  list(
    id = "ex4_2",
    lesson = "Lesson 4: GROUP BY",
    title = "Exercise 4.2: Average Area by Region",
    description = "Calculate the average farm area for each region.",
    hint = "Use AVG() with GROUP BY",
    solution = "SELECT region_id, AVG(area_hectares) as avg_area FROM farms GROUP BY region_id;",
    check_type = "exact"
  ),
  list(
    id = "ex4_3",
    lesson = "Lesson 4: GROUP BY",
    title = "Exercise 4.3: Total Production by Year",
    description = "Calculate the total quantity produced (in tonnes) for each year.",
    hint = "Use SUM() with GROUP BY",
    solution = "SELECT year, SUM(quantity_tonnes) as total_quantity FROM production GROUP BY year;",
    check_type = "exact"
  ),
  list(
    id = "ex4_4",
    lesson = "Lesson 4: GROUP BY",
    title = "Exercise 4.4: Production by Crop",
    description = "For each crop, calculate the total quantity produced in 2023.",
    hint = "Combine WHERE, GROUP BY, and SUM()",
    solution = "SELECT crop_id, SUM(quantity_tonnes) as total_quantity FROM production WHERE year = 2023 GROUP BY crop_id;",
    check_type = "exact"
  ),
  
  # Lesson 5: JOIN Operations
  list(
    id = "ex5_1",
    lesson = "Lesson 5: JOIN Operations",
    title = "Exercise 5.1: Simple JOIN",
    description = "Display farm names along with their region names. (Join the farms and regions tables)",
    hint = "Use JOIN regions ON farms.region_id = regions.region_id",
    solution = "SELECT farms.farm_name, regions.region_name FROM farms JOIN regions ON farms.region_id = regions.region_id;",
    check_type = "exact"
  ),
  list(
    id = "ex5_2",
    lesson = "Lesson 5: JOIN Operations",
    title = "Exercise 5.2: Three-Table JOIN",
    description = "Display production records with farm names and crop names for the year 2023. (Join production, farms, and crops tables)",
    hint = "Chain multiple JOINs together",
    solution = "SELECT farms.farm_name, crops.crop_name, production.quantity_tonnes FROM production JOIN farms ON production.farm_id = farms.farm_id JOIN crops ON production.crop_id = crops.crop_id WHERE production.year = 2023;",
    check_type = "exact"
  ),
  list(
    id = "ex5_3",
    lesson = "Lesson 5: JOIN Operations",
    title = "Exercise 5.3: JOIN with Aggregation",
    description = "For each region, calculate the total production quantity in 2022. (Join production, farms, and regions)",
    hint = "Combine JOIN with GROUP BY and SUM()",
    solution = "SELECT regions.region_name, SUM(production.quantity_tonnes) as total_production FROM production JOIN farms ON production.farm_id = farms.farm_id JOIN regions ON farms.region_id = regions.region_id WHERE production.year = 2022 GROUP BY regions.region_name;",
    check_type = "exact"
  ),
  
  # Lesson 6: ORDER BY and LIMIT
  list(
    id = "ex6_1",
    lesson = "Lesson 6: ORDER BY and LIMIT",
    title = "Exercise 6.1: Sort Regions by Population",
    description = "Display all regions sorted by population in descending order (highest first).",
    hint = "Use ORDER BY column_name DESC",
    solution = "SELECT * FROM regions ORDER BY population DESC;",
    check_type = "exact"
  ),
  list(
    id = "ex6_2",
    lesson = "Lesson 6: ORDER BY and LIMIT",
    title = "Exercise 6.2: Top 5 Largest Farms",
    description = "Display the top 5 farms with the largest area.",
    hint = "Use ORDER BY with LIMIT 5",
    solution = "SELECT farm_name, area_hectares FROM farms ORDER BY area_hectares DESC LIMIT 5;",
    check_type = "exact"
  ),
  list(
    id = "ex6_3",
    lesson = "Lesson 6: ORDER BY and LIMIT",
    title = "Exercise 6.3: Best Yields",
    description = "Find the top 3 production records with the highest yield per hectare in 2023.",
    hint = "Combine WHERE, ORDER BY, and LIMIT",
    solution = "SELECT * FROM production WHERE year = 2023 ORDER BY yield_tonne_ha DESC LIMIT 3;",
    check_type = "exact"
  ),
  
  # Challenge
  list(
    id = "challenge",
    lesson = "Challenge",
    title = "Final Challenge",
    description = "Write a query that shows: the crop name, the total quantity produced across all years, and the average yield per hectare. Sort by total quantity in descending order and show only the top 5 crops.",
    hint = "Use JOIN, GROUP BY, aggregate functions, ORDER BY, and LIMIT",
    solution = "SELECT crops.crop_name, SUM(production.quantity_tonnes) as total_quantity, AVG(production.yield_tonne_ha) as avg_yield FROM production JOIN crops ON production.crop_id = crops.crop_id GROUP BY crops.crop_name ORDER BY total_quantity DESC LIMIT 5;",
    check_type = "exact"
  )
)

function(input, output, session) {
  
  # Navigate to lesson 1 from intro
  observeEvent(input$start_lesson1, {
    updateTabItems(session, "sidebar", "lesson1")
  })
  
  # Function to create exercise UI
  create_exercise_ui <- function(ex) {
    ex_id <- ex$id
    
    div(class = "exercise-box",
        h3(ex$title),
        p(ex$description),
        textAreaInput(
          inputId = paste0("query_", ex_id),
          label = "Write your SQL query:",
          value = "",
          width = "100%",
          height = "150px",
          placeholder = "SELECT ...",
          resize = "vertical"
        ),
        fluidRow(
          column(3, actionButton(paste0("run_", ex_id), "Run Query", class = "btn-primary btn-run")),
          column(3, actionButton(paste0("check_", ex_id), "Check Answer", class = "btn-check")),
          column(3, actionButton(paste0("hint_", ex_id), "Show Hint", class = "btn-hint")),
          column(3, actionButton(paste0("solution_", ex_id), "Show Solution", class = "btn-warning"))
        ),
        conditionalPanel(
          condition = paste0("input.hint_", ex_id, " > 0"),
          div(class = "hint-box",
              strong("Hint: "), ex$hint
          )
        ),
        conditionalPanel(
          condition = paste0("input.solution_", ex_id, " > 0"),
          div(class = "hint-box",
              strong("Solution: "),
              tags$code(ex$solution)
          )
        ),
        uiOutput(paste0("feedback_", ex_id)),
        br(),
        DTOutput(paste0("result_", ex_id))
    )
  }
  
  # Render exercises for each lesson with concept explanations
  output$lesson1_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 1: SELECT Basics", exercises)
    c(lesson_content$lesson1$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$lesson2_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 2: WHERE Clause", exercises)
    c(lesson_content$lesson2$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$lesson3_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 3: Aggregate Functions", exercises)
    c(lesson_content$lesson3$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$lesson4_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 4: GROUP BY", exercises)
    c(lesson_content$lesson4$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$lesson5_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 5: JOIN Operations", exercises)
    c(lesson_content$lesson5$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$lesson6_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Lesson 6: ORDER BY and LIMIT", exercises)
    c(lesson_content$lesson6$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  output$challenge_exercises <- renderUI({
    lesson_exs <- Filter(function(ex) ex$lesson == "Challenge", exercises)
    c(lesson_content$challenge$concepts, lapply(lesson_exs, create_exercise_ui))
  })
  
  # Create observers for each exercise
  lapply(exercises, function(ex) {
    ex_id <- ex$id
    
    # Run query button
    observeEvent(input[[paste0("run_", ex_id)]], {
      query <- input[[paste0("query_", ex_id)]]
      
      if (nchar(trimws(query)) == 0) {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "error-msg", icon("exclamation-triangle"), " Please enter a SQL query.")
        })
        return()
      }
      
      result <- tryCatch({
        dbGetQuery(con, query)
      }, error = function(e) {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "error-msg", icon("exclamation-triangle"), " SQL Error: ", e$message)
        })
        return(NULL)
      })
      
      if (!is.null(result)) {
        output[[paste0("result_", ex_id)]] <- renderDT({
          datatable(result, options = list(pageLength = 10, scrollX = TRUE))
        })
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "success-msg", icon("check-circle"), " Query executed successfully! ", nrow(result), " rows returned.")
        })
      } else {
        output[[paste0("result_", ex_id)]] <- renderDT(NULL)
      }
    })
    
    # Check answer button
    observeEvent(input[[paste0("check_", ex_id)]], {
      user_query <- input[[paste0("query_", ex_id)]]
      solution_query <- ex$solution
      
      if (nchar(trimws(user_query)) == 0) {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "error-msg", icon("exclamation-triangle"), " Please enter a SQL query before checking.")
        })
        return()
      }
      
      user_result <- tryCatch({
        dbGetQuery(con, user_query)
      }, error = function(e) {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "error-msg", icon("exclamation-triangle"), " SQL Error: ", e$message)
        })
        return(NULL)
      })
      
      if (is.null(user_result)) {
        return()
      }
      
      solution_result <- tryCatch({
        dbGetQuery(con, solution_query)
      }, error = function(e) {
        return(NULL)
      })
      
      if (identical(user_result, solution_result)) {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "success-msg", icon("check-circle"), " Correct! Well done!")
        })
      } else {
        output[[paste0("feedback_", ex_id)]] <- renderUI({
          div(class = "error-msg", icon("times-circle"), " Not quite right. Your query returned different results. Try again!")
        })
      }
      
      output[[paste0("result_", ex_id)]] <- renderDT({
        datatable(user_result, options = list(pageLength = 10, scrollX = TRUE))
      })
    })
  })
  
  # Cleanup database connection when session ends
  session$onSessionEnded(function() {
    dbDisconnect(con)
  })
}