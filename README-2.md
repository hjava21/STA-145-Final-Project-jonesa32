# STA-215-Final-Project

This is the replication package for my STA 215 final project. My project looks at how all 30 NBA teams compare in on-court performance, financial value, fan popularity, and franchise history during the 2025-26 season.

## **Instructions**

To replicate my analysis, open "STA215-NBA-FINAL-PROJECT.R" in RStudio. It has all of the code for cleaning the data and making both tables, and it only uses base R, so no packages need to be installed. The data is in "NBA FINAL PROJ DATASET - raw.csv". Keep it in the same folder as the script, set your working directory to that folder, and run the script.

## **Data**

My dataset includes all 30 NBA teams, so each team is one observation and the sample size is 30. I collected all of the data by hand from public websites like NBA.com, ESPN, and Land of Basketball and entered it into a spreadsheet with one row per team. The performance, value, and popularity variables come from the 2025-26 season, and the history variables are totals across each franchise's whole history. I grouped my sixteen variables into four concepts: performance, value, popularity, and history. Most of my variables are quantitative, and two of them, sellout status and merchandise sales ranking, are qualitative variables coded as 0 or 1.

## **Operationalization**

To operationalize performance, I used four per-game stats. Points per game is each team's total points divided by the number of games played, and rebounds per game is total rebounds divided by games played. Both come from NBA.com. Points allowed per game is the total points a team gave up divided by games played, and turnovers per game is total turnovers divided by games played. Both of these come from ESPN.

To operationalize value, I used four variables. National TV games is the number of games each team plays on national TV, which I got from CableTV.com. Trade asset rank ranks every team's trade assets from 1 (the best) to 30, based on a ranking from Moneyline. Total revenue is how much money each team brings in, in millions of dollars, and franchise value is how much each team is worth, in billions of dollars. Both come from NBC Sports Bay Area's 2026 franchise valuations.

To operationalize popularity, I used two quantitative variables and two qualitative ones. Average home attendance is the average number of fans at each home game, from ESPN. Ticket revenue is the money each team makes from ticket sales, in millions of dollars, from TalkBasket. Sellout status is coded 1 if a team's home games sell out and 0 if they do not, based on BasketNews. Merchandise sales ranking is coded 1 if a team is one of the NBA's top merchandise sellers and 0 if it is not, based on TalkBasket's merchandise sales list.

To operationalize history, I used four totals for each franchise. Championships is the total number of NBA championships the franchise has won, and playoff appearances is the total number of seasons the team made the playoffs. Both come from Land of Basketball. All-time wins is the total number of regular-season wins in franchise history, from StatMuse. Hall of Fame players is the number of players connected to the franchise who are in the Naismith Basketball Hall of Fame.

## **Data Cleaning**

The R script cleans the raw data before running any analysis. First, I renamed variables to fix spelling mistakes and make the names consistent, for example changing "ticket_revanue" to "ticket_revenue" and "championsip_count" to "championship_count". Next, I fixed a data entry mistake in the Celtics row, where the trade asset rank (19) and total revenue (439) were typed into the same cell. I also cleaned up the team names by making them all lowercase, changing "clipper" to "clippers", and relabeling a row that said "3.8B" as the Hornets. Then I removed the commas from numbers like attendance and all-time wins so R would read them as numbers. Finally, the script checks that there are exactly 30 teams with no missing values. I did not drop any teams or fill in any missing data.
