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

#' Create a new directory with the specified R template
#'
#' This function creates a new directory under the current directory, which will
#' contain the given files of the specified template, ready to be rendered.
#'
#' @param dirname name of the directory to create. If not specified, a directory
#' \emph{new-dir} will be created.
#' @param template which template to use?
#'
#' @details
#' The available templates are: \emph{united_html} (default), \emph{bookdown_lite}.
#' The name of the main \code{.Rmd} file will be \emph{index.Rmd}.
#'
#' @examples
#' \dontrun{
#' create_rtemp(dirname = "tmp_dir", template = "united_html")
#' }
#'
#' @export
create_rtemp = function(dirname = "new-dir", template = "united_html") {
  # check input
  temp = match.arg(template, c("united_html", "bookdown_lite"))

  # create directory
  if (dir.exists(dirname)) {
    stop(paste0("There is already a directory `", dirname,
                "`. Please specify a different directory name"))
  }
  dir.create(dirname)

  # copy files from template directory
  if (temp == "bookdown_lite") {
    copy_bookdown_template_files(dirname)
  } else {
    template.dir = system.file(file.path("rmarkdown", "templates", "united_html", "skeleton"), package = "rtemps")
    files.to.copy = list.files(template.dir)
    file.copy(file.path(template.dir, files.to.copy), file.path(dirname), recursive = TRUE)
    file.rename(file.path(dirname, "skeleton.Rmd"), file.path(dirname, "index.Rmd"))
  }
}

#' Create Bookdown Lite Project Template
#'
#' Code was copied from the \href{https://github.com/rstudio/bookdown/blob/master/R/skeleton.R}{bookdwon package}.
#'
#' @importFrom xfun read_utf8 write_utf8
copy_bookdown_template_files = function(path) {
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # copy 'resources' folder to path
  resources = system.file('rstudio', 'templates', 'project', 'resources', package = 'rtemps', mustWork = TRUE)

  files = list.files(resources)

  source = file.path(resources, files)
  target = file.path(path)
  file.copy(source, target, recursive = TRUE)

  # add book_filename to _bookdown.yml and default to the base path name
  f = file.path(path, '_bookdown.yml')
  x = xfun::read_utf8(f)
  xfun::write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  TRUE
}

#' Dummy function to suppress R CMD check note on some platforms
#'
#' @importFrom bookdown render_book
#' @importFrom rmarkdown render
#' @importFrom knitr read_chunk
#' @importFrom DT datatable
#' @importFrom ggplot2 aes
dummy_fun = function() {
  is.function(bookdown::render_book)
  is.function(rmarkdown::render)
  is.function(knitr::read_chunk)
  is.function(DT::datatable)
  is.function(ggplot2::aes)
}
