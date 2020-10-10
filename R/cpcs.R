library(rmarkdown)

# Features of the CPCS Template
cpcs <- function(toc = TRUE, code_folding = "hide", number_sections=TRUE) {

  # get the locations of resource files located within the package
  css <- system.file("rmarkdown", "templates", "cpcs" ,"resources", "style.css", package = "cpcstemplate")
  template <- system.file("rmarkdown", "templates", "cpcs" ,"resources", "template_cpcs.html", package = "cpcstemplate")
  logo <- system.file("rmarkdown", "templates", "cpcs" ,"resources", "cpcs_logo.jpg", package = "cpcstemplate")

  # call the base html_document function
  rmarkdown::html_document( theme= "lumen",
                               template= template,
                               css= css,
                               logo= logo,
                               toc= toc,
                               toc_float = TRUE,
                               toc_depth = 2,
                               number_sections= number_sections,
                               df_print = "paged",
                               code_folding = code_folding,
                            )
}

cpcs_logo <- function() {
  system.file("rmarkdown", "templates", "cpcs" ,"resources", "cpcs_logo.jpg", package = "cpcstemplate")
}
