source("runtime_functions.R")

# Set an endpoint to return a pet name
#* @get /names
get_names <- function(){
  generate_many_names(20, model, character_lookup, max_length)
}
