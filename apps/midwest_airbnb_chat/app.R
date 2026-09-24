# ISA 401 Job Scout Chat: ask questions, get SQL, a table, or a chart back
library(querychat)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat::querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

library(shiny)
library(bslib)

# Make these your own
app_title = "Midwest Airbnb Chat"
author_name = "Kyle Dodson"

options(querychat.tool_details = "expanded")

ui = page_sidebar(
  title = app_title,
  
  theme = bs_theme(
    version = 5,
    primary = "#1E3A5F",    # Navy blue
    secondary = "#2A9D8F",  # Teal
    bg = "#F5F7FA",         # Light background
    base_font = "Arial"
  ),
  
  sidebar = qc$sidebar(width = 350),
  
  card(
    card_header(textOutput("title")),
    DT::DTOutput("table")
  ),
  
  accordion(
    open = "SQL",
    
    accordion_panel(
      "SQL",
      p("SQL for the currently displayed listings:"),
      verbatimTextOutput("sql")
    ),
    
    accordion_panel(
      "About",
      p(paste("Built by", author_name, "for ISA 401.")),
      p(
        "Explore 14,887 Airbnb listings in Chicago,",
        "Columbus, and the Twin Cities."
      ),
      p(
        "Data source: ",
        tags$a(
          "Inside Airbnb",
          href = "https://insideairbnb.com/get-the-data/",
          target = "_blank"
        )
      ),
      tags$ul(
        tags$li("Chicago: July 20, 2026"),
        tags$li("Columbus: July 23, 2026"),
        tags$li("Twin Cities: July 21, 2026")
      )
    )
  )
)

server = function(input, output, session) {
  vals = qc$server()
  
  output$title = renderText({
    current_title = vals$title()
    
    if (is.null(current_title) || !nzchar(current_title)) {
      "All Airbnb listings"
    } else {
      current_title
    }
  })
  
  output$table = DT::renderDT(
    vals$df(),
    options = list(pageLength = 10, scrollX = TRUE),
    rownames = FALSE,
    server = TRUE
  )
  
  output$sql = renderText({
    current_sql = vals$sql()
    
    if (is.null(current_sql) || !nzchar(current_sql)) {
      "SELECT * FROM listings"
    } else {
      current_sql
    }
  })
}

shinyApp(ui, server)
