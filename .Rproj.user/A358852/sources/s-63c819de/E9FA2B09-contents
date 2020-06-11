backgroundModule <- function(id) {
  ns <- NS(id)
  
  menu_title <- "Background"
  
  tab_titles <-
    c("History",
      "Materials and Manufacturing",
      "Dimensions")
  
  navbarMenu(
    menu_title,
    tabPanel(
      tab_titles[1],
      includeMarkdown("www/markdown/history.Rmd")
    ),
    tabPanel(
      tab_titles[2],
      includeMarkdown("www/markdown/materials.Rmd")
    ),
    tabPanel(
      tab_titles[3],
      includeMarkdown("www/markdown/dimensions.Rmd")
    )
  )
}