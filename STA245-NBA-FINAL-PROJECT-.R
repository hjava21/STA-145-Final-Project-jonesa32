#######################################################
## STA 215 Final Project
## NBA Team Performance, Value, Popularity, and History
## File: STA215-NBA-FINAL-PROJECT.R
## Date: November 23 2026
## Author: Ava Harris-Jones
#######################################################

## Set the working directory to the folder with this script and the dataset
## (Session > Set Working Directory > To Source File Location)

## Load the data
dataset <- read.csv("NBA FINAL PROJ DATASET - raw.csv")
View(dataset)


#######################################################
##                  DATA CLEANING
#######################################################

## Rename the variables so they are spelled right and consistent
names(dataset) <- c("team", "points_per_game", "rebounds_per_game",
                    "points_allowed_per_game", "turnovers_per_game",
                    "national_tv_games", "trade_asset_rank", "total_revenue",
                    "franchise_value", "avg_home_attendance", "ticket_revenue",
                    "sellout_status", "merch_top_seller", "championship_count",
                    "playoff_appearances", "all_time_wins", "hall_of_fame_players")

## Fix the Celtics row (trade asset rank and revenue got typed into the same cell)
dataset$trade_asset_rank[dataset$team == "celtics"] <- "19"
dataset$total_revenue[dataset$team == "celtics"] <- 439
dataset$trade_asset_rank <- as.numeric(dataset$trade_asset_rank)

## Fix the team names
dataset$team <- tolower(dataset$team)
dataset$team[dataset$team == "clipper"] <- "clippers"
dataset$team[dataset$team == "3.8b"] <- "hornets"

## Take the commas out of attendance and all-time wins so R reads them as numbers
dataset$avg_home_attendance <- as.numeric(gsub(",", "", dataset$avg_home_attendance))
dataset$all_time_wins <- as.numeric(gsub(",", "", dataset$all_time_wins))

## Check the cleaned data (should be 30 teams with no missing values)
nrow(dataset)
sum(is.na(dataset))
View(dataset)


#######################################################
##           TABLE 1: DESCRIPTIVE STATISTICS
#######################################################

## Mean, min, and max for every variable
summary(dataset)

## Standard deviations for the quantitative variables
## Performance
sd(dataset$points_per_game)
sd(dataset$rebounds_per_game)
sd(dataset$points_allowed_per_game)
sd(dataset$turnovers_per_game)

## Value
sd(dataset$national_tv_games)
sd(dataset$trade_asset_rank)
sd(dataset$total_revenue)
sd(dataset$franchise_value)

## Popularity
sd(dataset$avg_home_attendance)
sd(dataset$ticket_revenue)

## History
sd(dataset$championship_count)
sd(dataset$playoff_appearances)
sd(dataset$all_time_wins)
sd(dataset$hall_of_fame_players)

## Qualitative variables (1 = yes, 0 = no)
table(dataset$sellout_status)
prop.table(table(dataset$sellout_status))

table(dataset$merch_top_seller)
prop.table(table(dataset$merch_top_seller))


#######################################################
##   TABLE 2: CROSS TAB OF SELLOUT STATUS BY MERCH
#######################################################

table2 <- table(dataset$sellout_status, dataset$merch_top_seller)
table2

## Row totals and row percentages
addmargins(table2)
prop.table(table2, 1)

## Chi-square test
chisq.test(table2)
