analysisModuleInput <- function(id, module_name_1, module_name_2) {
  ns <- NS(id)
  
  tab_title <- "Analysis"
  dropdown_names <- c("Instructions", "Data Visualization")
  instructions_filepath <- "www/markdown/visualizationInstructions.Rmd"
  
  navbarMenu(
    tab_title,
    tabPanel(
      dropdown_names[1],
      includeMarkdown(instructions_filepath)),
    tabPanel(
      dropdown_names[2],
      analysisDisplayInput(module_name_1),
      analysisDisplayInput(module_name_2)
    )
  )
}