# STA 215 Final Project: NBA Team Performance, Value, Popularity, and History

Replication package for my STA 215 final project, which looks at how all 30 NBA teams compare on on-court performance, financial value, fan popularity, and franchise history in the 2025–26 season.

## Instructions

1. Download this repository: click the green **Code** button → **Download ZIP**, then unzip it.
2. Open `STA215-NBA-FINAL-PROJECT.R` in RStudio. It contains all of the code. It uses base R only, so no packages need to be installed.
3. Make sure `NBA FINAL PROJ DATASET - raw.csv` is in the same folder as the script, then set the working directory to that folder (**Session → Set Working Directory → To Source File Location**).
4. Run the whole script. It:
   - cleans the raw data and saves it as `NBA FINAL PROJ DATASET - clean.csv`
   - produces **Table 1** (descriptive statistics) and saves it as `Table 1 - Descriptive Statistics.csv`
   - produces **Table 2** (cross tab of sellout status by merchandise top seller, with a chi-square test) and saves it as `Table 2 - Cross Tab.csv`

## Files

- `README.md`: this file
- `STA215-NBA-FINAL-PROJECT.R`: R script for data cleaning and all analyses
- `NBA FINAL PROJ DATASET - raw.csv`: the dataset as collected

## Data

The unit of analysis is the NBA team. The sample includes all 30 NBA franchises (n = 30). Seasonal measures come from the 2025–26 season, and history measures are franchise totals. I collected the data by hand from public sources and entered it into a spreadsheet, one row per team. `team` identifies each franchise by its lowercase nickname.

### Operationalization

I measure four concepts: performance, value, popularity, and history.

**Performance**
- **Points per game** (`points_per_game`): team total points divided by games played. Numeric. Source: [NBA.com](https://www.nba.com/stats/teams/traditional?SeasonType=Regular+Season)
- **Rebounds per game** (`rebounds_per_game`): team total rebounds divided by games played. Numeric. Source: [NBA.com](https://www.nba.com/stats/teams/traditional?SeasonType=Regular+Season)
- **Points allowed per game** (`points_allowed_per_game`): total points allowed divided by games played. Numeric. Source: [ESPN](https://www.espn.com/nba/stats/team/_/view/opponent/table/offensive/sort/avgPoints/dir/asc)
- **Turnovers per game** (`turnovers_per_game`): total turnovers divided by games played. Numeric. Source: [ESPN](https://www.espn.com/nba/stats/team/_/sort/avgTurnovers)

**Value**
- **National TV games** (`national_tv_games`): number of nationally televised games. Numeric (count). Source: [CableTV.com](https://www.cabletv.com/news/national-tv-games-for-every-nba-team)
- **Trade asset rank** (`trade_asset_rank`): ranking of the team's trade assets, from 1 (best) to 30. Numeric rank. Source: [Moneyline](https://moneyline.com/news/nba_trade_assets_update__ranking_all_30_teams_after_wild)
- **Total revenue** (`total_revenue`): money the team brings in, in millions of dollars. Numeric. Source: [NBC Sports Bay Area](https://www.nbcsportsbayarea.com/nba/2026-nba-franchise-valuations/1911711/)
- **Franchise value** (`franchise_value`): what the franchise is worth, in billions of dollars. Numeric. Source: [NBC Sports Bay Area](https://www.nbcsportsbayarea.com/nba/2026-nba-franchise-valuations/1911711/)

**Popularity**
- **Average home attendance** (`avg_home_attendance`): average number of fans at each home game. Numeric (attendees). Source: [ESPN](https://www.espn.com/nba/attendance/_/year/2026)
- **Ticket revenue** (`ticket_revenue`): revenue from ticket sales, in millions of dollars. Numeric. Source: [TalkBasket](https://www.talkbasket.net/216192-knicks-lakers-top-nba-merchandise-sales-list-for-2025-26-season)
- **Home game sellout** (`sellout_status`): whether the team's home games sell out. 1 = Sold out; 0 = Not sold out. Source: [BasketNews](https://basketnews.com/news-245164-nba-sets-record-attendance-and-viewership-numbers-for-2025-26-season.html)
- **Merchandise sales ranking** (`merch_top_seller`): whether the team ranks among the NBA's top merchandise sellers. 1 = Top seller; 0 = Not top seller. Source: [TalkBasket](https://www.talkbasket.net/216192-knicks-lakers-top-nba-merchandise-sales-list-for-2025-26-season)

**History**
- **Championships** (`championship_count`): total NBA championships won by the franchise. Numeric (count). Source: [Land of Basketball](https://www.landofbasketball.com/championships/summary_of_winners.htm)
- **Playoff appearances** (`playoff_appearances`): total seasons in which the team made the playoffs. Numeric (count). Source: [Land of Basketball](https://www.landofbasketball.com/statistics/all_time_playoff_standings.htm)
- **All-time wins** (`all_time_wins`): total regular-season wins in franchise history. Numeric (count). Source: [StatMuse](https://www.statmuse.com/nba/ask/most-wins-by-a-franchise-nba-history)
- **Hall of Fame players** (`hall_of_fame_players`): number of players tied to the franchise who are in the Hall of Fame. Numeric (count). Source: [Naismith Hall of Fame](https://www.hoophall.com/hall-of-famers)

### Data cleaning

The R script cleans the raw dataset in these steps:

1. Renamed variables to consistent names and fixed spelling (`unique` → `team`, `TV_ aperances_Nationally` → `national_tv_games`, `Trade_asset` → `trade_asset_rank`, `ticket_sales` → `total_revenue`, `Money_ value` → `franchise_value`, `ticket_revanue` → `ticket_revenue`, `championsip_count` → `championship_count`).
2. Fixed a data-entry error in the Celtics row, where trade asset rank (19) and total revenue (439) had been typed into one cell.
3. Standardized team names: all lowercase, `clipper` → `clippers`, and the row mislabeled `3.8B` relabeled as `hornets`.
4. Removed thousands separators (for example, `18,996` → `18996`) and converted all variables to numbers.
5. Checked that the cleaned data has exactly 30 unique teams and no missing values.

No teams were dropped, and no values were imputed.
