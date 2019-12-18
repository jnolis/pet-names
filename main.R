library(plumber)

r <- plumb("rest_controller.R")
# Get PORT env var for Cloud Run
PORT <- strtoi(Sys.getenv("PORT", 8080))
r$run(port=PORT, host="0.0.0.0")
