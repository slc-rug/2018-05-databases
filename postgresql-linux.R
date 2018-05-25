### RPostgreSQL setup ###

# sudo apt-get install libpq-dev
# install.packages("RPostgreSQL")

library(RPostgreSQL)
library(getPass)

pgdrv <- dbDriver(drvName = "PostgreSQL")

db <-DBI::dbConnect(pgdrv,
                    dbname="postgres",
                    host="localhost", port=5432,
                    user = 'postgres',
                    password = getPass("Enter Password:"))

# Write to database
DBI::dbWriteTable(db, "mtcars", mtcars)

DBI::dbDisconnect(db)


### odbc setup ###

# # Install the unixODBC library
# apt-get install unixodbc unixodbc-dev
# 
# # PostgreSQL ODBC Drivers
# apt-get install odbc-postgresql

# Set up connection with connection string
db <- DBI::dbConnect(odbc::odbc(),
                     Driver = "PostgreSQL Unicode",
                     Database = "postgres",
                     UserName = "postgres",
                     Password = getPass("Enter Password:"),
                     Servername = "localhost",
                     Port = 5432)

# Set up connection with DSN
# - Modify /etc/odbc.ini 
db <- dbConnect(odbc::odbc(), "PostgreSQL")

DBI::dbGetQuery(db,"SELECT * FROM MTCARS")


DBI::dbDisconnect(db)


### RJDBC setup ###
# install.packages('RJDBC')
library(RJDBC)

db <- DBI::dbConnect(RJDBC::JDBC("org.postgresql.Driver","postgresql-42.2.2.jar"),
               url = "jdbc:postgresql://localhost:5432/postgres",
               user = "postgres",
               password = getPass("Enter Password:"))

DBI::dbGetQuery(db,"SELECT * FROM MTCARS")

DBI::dbDisconnect(db)
