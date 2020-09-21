## NEED TO RUN TWICE TO WORK: 
  # First time error about not all files in the same folder?


# Book variables
if (file.exists("_main.Rmd") == TRUE) file.remove("_main.Rmd")

# folder_name = paste0("docs/")

cat("\n\n• GENERATING BOOK •\n")

# A output_dir no se le pueden meter variables creadas en este environment
bookdown::render_book('index.Rmd', 
                      'all', 
                      output_dir = "docs/",
                      quiet = FALSE, 
                      config_file = "_bookdown.yml")

