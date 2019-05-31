# Book variables
if (file.exists("_main.Rmd") == TRUE) file.remove("_main.Rmd")

# folder_name = paste0("docs/")

cat("\n\n• GENERATING BOOK •\n")

# tictoc::tic()

# A output_dir no se le pueden meter variables creadas en este environment
bookdown::render_book('index.Rmd', 
                      'all', 
                      output_dir = "docs/",
                      quiet = FALSE, 
                      config_file = "_bookdown.yml")

# final_message = paste0("\n", "•• Book succesfully generated in: ", folder_name, " •• \n\n")
# tictoc::toc()



# cat(final_message)
