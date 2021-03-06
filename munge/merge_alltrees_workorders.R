# Adam Laiacano
# Required input: Alltrees_20120606_latlon.csv from the DataKind dropbox at 
# https://www.dropbox.com/sh/8ubk2cxtdbway25/6UVgKPLtoG/Alltrees_20120606.csv


library(ggplot2)
library(plyr)
library(maps)
rm(list=ls())

# Load data from Street Trees Census
street.trees <- read.csv("~/Dropbox/GitRepository/ParksDataDive2012/Alltrees_20120606.csv", 
                         header=TRUE,
                         stringsAsFactors=FALSE)
names(street.trees) <- c(
    'side',
    'address',
    'dbh',
    'season',
    'contract',
    'boro',
    'contract.number',
    'work.order.id',
    'location',
    'species',
    'census',
    'young.tree',
    'tree.adopt',
    'tree.id',
    'join.field',
    'join.field2',
    'lon',
    'lat'
)

street.trees <- subset(street.trees, select = c(
    'side',
    'dbh',
    'address',
    'season',
    'boro',
    'species',
    'census',
    'young.tree',
    'tree.id',
    'lon',
    'lat'
    ))

street.trees$boro[street.trees$boro==1] <- "Manhattan"
street.trees$boro[street.trees$boro==2] <- "Bronx"
street.trees$boro[street.trees$boro==3] <- "Brooklyn"
street.trees$boro[street.trees$boro==4] <- "Queens"
street.trees$boro[street.trees$boro==5] <- "Staten Island"
street.trees$boro <- factor(street.trees$boro)
write.csv(street.trees, "~/Dropbox/GitRepository/ParksDataDive2012/StreetTrees")

# removals
work.orders <- read.csv("~/Dropbox/GitRepository/ParksDataDive2012/WorkOrders_NamesCleaned.csv")
work.orders <- subset(work.orders, WOCATEGORY == 'TREEREMV' & STATUS %in% c("CLOSED", "COMPLETE"), 
                      select = c(
    'WORKORDERID',
    'WOXCOORDINATE',
    'WOYCOORDINATE',
    'ACTUALFINISHDATE',
    'STATUS', # CLOSED, COMPLETE
    'Text8'
    ))
names(work.orders) <- c(
    'work.order.id',
    'x',
    'y',
    'finish.date',
    'status',
    'species2'
    )

write.csv(work.orders, file='~/Dropbox/GitRepository/ParksDataDive2012/WorkOrders.csv', na="", row.names=FALSE)
