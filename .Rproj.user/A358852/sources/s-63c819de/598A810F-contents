projectModule <- function(id) {
  ns <- NS(id)
  
  menu_title <- "Project"
  tab_titles <-
    c(
      "Poster",
      "Abstract",
      "Mouthpieces",
      "Workflow",
      "Conclusions",
      "Student Profile",
      "Acknowledgments"
    )
  tab_markdown <- c("www/markdown/abstract.Rmd",
                    "www/markdown/mouthpieces.Rmd",
                    "www/markdown/workflow.Rmd",
                    "www/markdown/conclusions.Rmd",
                    "www/markdown/acknowledgments.Rmd")
  
  
  navbarMenu(
    menu_title,
    tabPanel(
      tab_titles[1],
      tags$iframe(style = "height:600px; width:100%; scrolling=yes",
                  src = "poster.pdf")
    ),
    tabPanel(
      tab_titles[2],
      includeMarkdown(tab_markdown[1])
    ),
    tabPanel(
      tab_titles[3],
      includeMarkdown(tab_markdown[2])
    ),
    tabPanel(
      tab_titles[4],
      includeMarkdown(tab_markdown[3])
    ),
    tabPanel(
      tab_titles[5],
      includeMarkdown(tab_markdown[4])
    ),
    tabPanel(tab_titles[6],
             fluidRow(
               column(
                 6,
                 "Gia Jadick - Trinity 2020",
                 tags$video(
                   width = "100%",
                   height = "100%",
                   src = "videos/gia.mp4",
                   controls = "controls"
                 )
               ),
               column(
                 6,
                 "Max Bartlett - Trinity 2020",
                 tags$video(
                   width = "100%",
                   height = "100%",
                   src = "videos/max.mp4",
                   controls = "controls"
                 )
               )
             )),
    tabPanel(
      tab_titles[7],
      includeMarkdown(tab_markdown[5])
    )
  )
}