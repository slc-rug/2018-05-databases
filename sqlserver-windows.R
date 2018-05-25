# install.packages(c('odbc','dplyr'))

library(odbc)
library(getPass)
library(dbplyr)

# Connect using the DSN
db <- DBI::dbConnect(odbc::odbc(), "SQL")

# Connect without a DSN
db <- DBI::dbConnect(odbc::odbc(),
                     Driver = 'ODBC Driver 13 for SQL Server',
                     Server = 'DB-DEV',
                     Database = "ML",
                     trusted_connection = 'yes',
                     Port = 1433
                     )

# dbWriteTable(db,"iris",iris)

dbGetQuery(db,"SELECT * FROM IRIS")

smry <- tbl(db,"iris") %>% collect

dbDisconnect(db)
