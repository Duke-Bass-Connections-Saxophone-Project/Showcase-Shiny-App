archiveModuleInput <- function(id, module_name_1, module_name_2) {
  tab_title <- "Archive"
  dropdown_names <- c("Instructions", "Audiovisual Media")
  instructions_filepath <- "www/markdown/archiveInstructions.Rmd"
  archive_note_text <-
    "Note: Mouthpiece scans have been displayed at 1/150th of their original resolution.
                      Mouthpiece scans and recording do not exist for some mouthpieces and players."
  tab_style <- "padding:10px"
  
  ns <- NS(id)
  
  navbarMenu(
    tab_title,
    tabPanel(dropdown_names[1],
             includeMarkdown(instructions_filepath)),
    tabPanel(
      dropdown_names[2],
      style = tab_style,
      archiveDisplayInput(module_name_1),
      archiveDisplayInput(module_name_2),
      fluidRow(tags$i(archive_note_text))
    )
  )
}