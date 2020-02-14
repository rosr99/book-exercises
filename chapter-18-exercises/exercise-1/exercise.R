# Author: Ryan Ros

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")
key_param <- list(api_key = ny_key)

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Interstellar"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
# Send the HTTP Request to download the data
# Extract the content and convert it from JSON


base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
base_resource_uri <- paste0(base_uri, resource)
params_list <- list(query = movie_name, "api-key" = key_param)

# url example: https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=godfather&api-key=yourkey
movie_review_response <- GET(base_resource_uri, query = params_list)
movie_review_response_text <- content(movie_review_response, type = "text", encoding = "UTF-8")
movie_review_response_data <- fromJSON(movie_review_response_text)
movie_review_data <- movie_review_response_data
View(movie_review_data)


# What kind of data structure did this produce? A data frame? A list?
# A: It produced a list, not a data frame

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.

names(movie_review_data)
str(movie_review_data)


# Flatten the movie reviews content into a data structure called `reviews`

reviews <- flatten(movie_review_data$results)
View(reviews)


# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables

recent_review <- list(Headline = reviews$headline,
                      Short_Summary = reviews$summary_short,
                      Article_Link = reviews$link.url)



# Create a list of the three pieces of information from above. 
# Print out the list.
print(recent_review)
