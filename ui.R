shinyUI(
  navbarPage(
    title = div(
      img(
        src = "markdown/images/bass-connections-logo.png",
        style = "margin-top: -5px; padding-right:5px;padding-bottom:0px",
        height = 30
      ),
      "The Art and Craft of Saxophone Mouthpiece Design"
    ),
    windowTitle = "Duke University Bass Connections - The Art and Craft of Saxophone Mouthpiece Design",
    projectModule("project"),
    backgroundModule("background"),
    archiveModuleInput("archive", archive_module_names[1], archive_module_names[2]),
    analysisModuleInput("analysis", analysis_module_names[1], analysis_module_names[2]),
    theme = "css/bootstrap.css",
    position = "fixed-top",
    collapsible = TRUE,
    tags$head(tags$style(
      HTML(
        ".tab-content {margin-top:.25in;margin-bottom:1in;margin-left:1in;margin-right:1in}"
      )
    )),
    tags$style(type = "text/css", "body {padding-top: 70px;}")
  )
)