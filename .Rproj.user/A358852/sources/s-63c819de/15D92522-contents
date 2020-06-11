library(tidyverse)
library(shiny)
library(shinythemes)
library(rgl)
library(shinyRGL)
library(readobj)
library(shinycssloaders)
library(rmarkdown)

archive_module_names <- c("archive_display_1", "archive_display_2")
analysis_module_names <- c("analysis_display_1", "analysis_display_2")

files <- list.files("modules", full.names=TRUE, recursive=TRUE)

for(file in files) {
  source(file)
}
