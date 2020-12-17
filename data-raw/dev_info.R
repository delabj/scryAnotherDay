library(devtools)
library(usethis)
library(desc)

# Remove default DESC
unlink("DESCRIPTION")
# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "ScryfallR")

# Set your name
my_desc$set("Authors@R", "person('Joshua', 'de la Bruere', email = 'joshua@delabj.com', role = c('cre', 'aut'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.0.1000")

# The title of your package
my_desc$set(Title = "A wrapper for the Scryfall API")
# The description of your package
my_desc$set(Description = "A R interface to the Scryfall REST API.
                Scryfall provides a database of Magic The Gathering Cards with related information.")
# The urls
my_desc$set("URL", "https://github.com/delabj/scryfallR")
my_desc$set("BugReports", "https://github.com/delabj/scryfallR/issues")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
use_mit_license(name = "Joshua de la Bruere")
use_code_of_conduct()
use_lifecycle_badge("Experimental")
use_news_md()

# Get the dependencies
use_package("httr")
use_package("jsonlite")
use_package("curl")
use_package("attempt")
use_package("purrr")
use_package("usethis")
use_package("magick")
use_package("readr")
use_package("assertthat")


# Clean your description
use_tidy_description()
