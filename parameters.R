character_lookup <- data.frame(character = c(letters,".","-"," ","+"))
character_lookup[["character_id"]] <- 1:nrow(character_lookup)

max_length <- 10
num_characters <- nrow(character_lookup) + 1