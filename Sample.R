
#------------------------------------
#----- Sample Project Tree in R -----
#------------------------------------

params <- NULL
params$dataname <- "cars"

# Installs missing libraries on render!
list.of.packages <- c("rmarkdown", "dplyr", "ggplot2", "Rcpp", "knitr", "Hmisc", "readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='https://cran.rstudio.com/')

# load libraries
library(dplyr)
library(knitr)
library(ggplot2)


# directory where the notebook is
wdir <- getwd() 
# directory where data are imported from & saved to
datadir <- file.path(wdir, "data") # better than datadir <- paste(wdir, "/data", sep="")
# directory where external images are imported from
imgdir <- file.path(wdir, "img")
# directory where plots are saved to
plotdir <- file.path(wdir, "plot")
# the folder immediately above root
wdirUp <- gsub("\\ProjectR", "", wdir) 


# Data import
#---- MSEXCEL
dataname <- params$dataname # archive name
routexl <- paste(datadir, "/", dataname, ".xlsx", sep="")  # complete route to archive
library(readxl)
mydata <- read_excel(routexl, sheet = 1)  # imports first sheet


#---- CSV / TSV (separated by tabs in this example)
dataname <- params$dataname # archive name
routecsv <- paste(datadir, "/", dataname, ".csv", sep="")  # complete route to archive
mydata <- read.csv(routecsv, 
                   header = TRUE, 
                   sep = "\t",
                   dec = ".")


# Data operations
# Hmisc::describe(mydata)
head(mydata)
p1 <- ggplot(cars, aes(x=speed, y=dist)) + geom_point()
p1


# Save plots
#---- TO PDF 
plotname1 <- "p1.pdf"
#---- TO PNG 
plotname2 <- "p1.png"
routeplot1 <- file.path(plotdir, plotname1)
routeplot2 <- file.path(plotdir, plotname2)
ggsave(routeplot1)  # (see http://ggplot2.tidyverse.org/reference/ggsave.html)
ggsave(routeplot2) 


# Save data
#---- RDATA
save(mydata, file="data/mydata.RData")

#---- MSEXCEL
dataname2 <- "mydata"  # name we will give to file
routexl2 <- paste(datadir, "/", dataname2, ".xlsx", sep="")   # complete route to future archive
library(xlsx)
write.xlsx(mydata, routexl2) # creates archive in specified route

#---- CSV / TSV (separated by tabs in this example)
dataname2 <- "mydata"  # name we will give to file
routecsv2 <- paste(datadir, "/", dataname2, ".csv", sep="")  # complete route to future archive

write.table(mydata, file = routecsv2, append = FALSE, quote = FALSE, sep = "\t ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE)

