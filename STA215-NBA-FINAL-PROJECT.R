################################################################################
##
## STA 215 Final Project: NBA Team Performance, Value, Popularity, and History
## File:    STA215-NBA-FINAL-PROJECT.R
## Date:    November 2026
## Author:  YOUR NAME HERE
##
## Uses base R only, so no packages need to be installed.
## Set your working directory to the folder that holds this script and the
## dataset (Session > Set Working Directory > To Source File Location).
##
################################################################################

################################################################################
##                              LOAD DATA
################################################################################

raw <- read.csv("NBA FINAL PROJ DATASET - raw.csv", check.names = FALSE,
                colClasses = "character")
dataset <- raw

################################################################################
##                            DATA CLEANING
################################################################################

# 1. Rename variables to consistent names and fix spelling
names(dataset)[names(dataset) == "unique"]                   <- "team"
names(dataset)[names(dataset) == "TV_ aperances_Nationally"] <- "national_tv_games"
names(dataset)[names(dataset) == "Trade_asset"]              <- "trade_asset_rank"
names(dataset)[names(dataset) == "ticket_sales"]             <- "total_revenue"
names(dataset)[names(dataset) == "Money_ value"]             <- "franchise_value"
names(dataset)[names(dataset) == "ticket_revanue"]           <- "ticket_revenue"
names(dataset)[names(dataset) == "championsip_count"]        <- "championship_count"

# 2. Fix the Celtics row: trade asset rank and revenue were typed into one cell ("19 439")
celtics <- dataset$team == "celtics"
split_cell <- strsplit(dataset$trade_asset_rank[celtics], " ")[[1]]
dataset$trade_asset_rank[celtics] <- split_cell[1]
dataset$total_revenue[celtics]    <- split_cell[2]

# 3. Standardize team names (lowercase, fix typos and the mislabeled Hornets row)
dataset$team <- tolower(trimws(dataset$team))
dataset$team[dataset$team == "clipper"] <- "clippers"
dataset$team[dataset$team == "3.8b"]    <- "hornets"

# 4. Remove thousands separators and convert every variable to numbers
num_vars <- setdiff(names(dataset), "team")
for (v in num_vars) {
  dataset[[v]] <- as.numeric(gsub(",", "", trimws(dataset[[v]])))
}

# 5. Check: 30 unique teams, no missing values
stopifnot(nrow(dataset) == 30, !any(duplicated(dataset$team)), !anyNA(dataset))

write.csv(dataset, "NBA FINAL PROJ DATASET - clean.csv", row.names = FALSE)

################################################################################
##                    TABLE 1: DESCRIPTIVE STATISTICS
################################################################################

quant_vars <- setdiff(num_vars, c("sellout_status", "merch_top_seller"))

table1 <- data.frame(
  Mean = sapply(dataset[quant_vars], mean),
  SD   = sapply(dataset[quant_vars], sd),
  Min  = sapply(dataset[quant_vars], min),
  Max  = sapply(dataset[quant_vars], max)
)
round(table1, 2)

# Qualitative variables: counts and percentages
table(dataset$sellout_status)
round(prop.table(table(dataset$sellout_status)) * 100, 1)

table(dataset$merch_top_seller)
round(prop.table(table(dataset$merch_top_seller)) * 100, 1)

nrow(dataset)   # n = 30

write.csv(round(table1, 2), "Table 1 - Descriptive Statistics.csv")

################################################################################
##          TABLE 2: CROSS TAB OF SELLOUT STATUS BY MERCH TOP SELLER
################################################################################

table2 <- table(sellout_status = dataset$sellout_status,
                merch_top_seller = dataset$merch_top_seller)
addmargins(table2)                                   # counts with totals
round(prop.table(table2, margin = 1) * 100, 1)       # row percentages

chisq.test(table2)

write.csv(as.data.frame.matrix(addmargins(table2)), "Table 2 - Cross Tab.csv")
