pew_download(
  area = "politics",
  file_id,
  email = getOption("pew_email"),
  password = getOption("pew_password"),
  reset = FALSE,
  download_dir = "pew_data",
  msg = TRUE,
  convert = TRUE,
  delay = 3
)

# The Pew Research Center has seven areas of research focus. Pass one of the following strings to the area argument to specify which area generated the datasets you want to download:
  
# politics U.S. Politics & Policy (the default)

# journalism Journalism & Media

# socialtrends Social & Demographic Trends

# religion Religion & Public Life

# internet Internet & Technology

# science Science & Society

# hispanic Hispanic Trends

# global Global Attitudes & Trends

# To avoid requiring others to edit your scripts to insert their own contact information, the default is set to fetch this information from the user's .Rprofile. Before running pew_download, then, you should be sure to add these options to your .Rprofile substituting your info for the example below:

# options("pew_email" = "jherrera@uppermidwest.edu" "pew_password" = "password123!")


##Example:
## Not run: 
pew_download(file_id = c("september-2018-political-survey", "june-2018-political-survey"))

## End(Not run)