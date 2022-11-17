/*

The purpose of this project was to conduct an exploratory analysis of a data set composed of Steam data.

There are four columns: 

User_ID: the ID of the player
Game_Title: The title of the game
Behavior: The action that was taken (Purchase or Play)
Value: Behavior represented numerically (Purchase = 1, Play = amount of hours spent playing a game)

The following research questions were asked:

1. Collectively, which games have the most/least amount of hours put into them?
2. Which games have been purchased the most/least on Steam?
3. Which Call of Duty title has the most/least amount of hours put into it? 
4. Which Call of Duty title has been purchased the most/least?
5. Which games have been purchased the most but have the least amount of playtime?
6. What percentage of users purchase a game but never actually play it (i.e., hours played = 0)?

*/
# Selects all columns from table
SELECT * FROM Steam_Data.steamdata;

# Selects the game title, behavior, and hours played from table
SELECT Game_Title, Behavior, Value
FROM Steam_Data.steamdata;

# Filters behavior to only include rows with "play" in behavior col
SELECT Game_Title, Behavior, Value
FROM Steam_Data.steamdata
WHERE Behavior = "play";

# Finds which game has the most hours put into it
SELECT Game_Title, SUM(Value) AS max_hours # Adds total hours played per game, per user
FROM Steam_Data.steamdata
WHERE Behavior = "play" # Filter rows where Behavior is play
GROUP BY Game_Title # Groups hours by game
ORDER BY SUM(Value) DESC # Orders games starting with highest hours
LIMIT 1 ;

# Finds which game has the least hours put into it
SELECT Game_Title, SUM(Value) AS max_hours # Adds total hours played per game, per user
FROM Steam_Data.steamdata
WHERE Behavior = "play" # Only adds rows with "play" as the behavior
GROUP BY Game_Title # Groups hours by game
HAVING SUM(Value) >= 10 AND SUM(Value) < 20 # Find values between a range of no greater than 10 but less than 20
ORDER BY SUM(Value) ASC ; # Orders games starting with lowest hours ;

# Find which games have been purchased the most on Steam
SELECT Game_Title, COUNT(Behavior) AS total_purchases # Counts amount of times "purchases" is seen
FROM Steam_Data.steamdata
WHERE Behavior = "purchase" # Only adds rows with "purchase" as the behavior
GROUP BY Game_Title # Groups purchases by game
ORDER BY COUNT(Behavior) DESC; # Orders games starting with the highest purchases

# Find which games have been purchased the least on Steam
SELECT Game_Title, COUNT(Behavior) AS total_purchases # Counts amount of times "purchases" is seen
FROM Steam_Data.steamdata
WHERE Behavior = "purchase" # Only adds rows with "purchase" as the behavior
GROUP BY Game_Title # Groups purchases by game
ORDER BY COUNT(Behavior) ASC; # Orders games starting with the lowest purchases

# Which Call of Duty games exist on steam (aka how old is this data set?)?
SELECT * 
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%"; # Filters Game_Titles that start with "Call of Duty"

# Which Call of Duty experience has the most amount of hours put into it? 
SELECT Game_Title, Behavior, SUM(Value) as max_cod_hours # Adds up total playtime
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "play" # Filters rows to only include COD and hours played
GROUP BY Game_Title  # Groups hours played per game
ORDER BY SUM(Value) DESC; # Displays highest hours first

# Which Call of Duty experience has the least amount of hours put into it? 
SELECT Game_Title, Behavior, SUM(Value) as max_cod_hours # Adds up total playtime
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "play" # Filters rows to only include COD and hours played
GROUP BY Game_Title # Groups hours played per game
ORDER BY SUM(Value) ASC; # Displays lowest hours first

# Which Call of Duty experience has the most amount of purchases?
SELECT Game_Title, COUNT(Behavior) AS max_cod_purchases # Adds up total purchases
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "purchase" # Filters rows to only include COD and purchases
GROUP BY Game_Title # Groups hours played per game
ORDER BY COUNT(Behavior) DESC; # Displays highest purchase numbers first

# Which Call of Duty experience has the least amount of purchases?
SELECT Game_Title, COUNT(Behavior) AS max_cod_purchases # Adds up total purchases
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "purchase" # Filters rows to only include COD and purchases
GROUP BY Game_Title # Groups hours played per game
ORDER BY COUNT(Behavior) ASC; # Displays lowest purchase numbers first

# Seperates max purchases and max hours into two seperate cols
SELECT Game_Title,
COUNT(CASE WHEN Behavior = "purchase" THEN Value END) AS max_purchases, # When Behavior = purchase, count it
SUM(CASE WHEN Behavior = 'play' THEN Value END) AS max_hours # When behavior = play, count it
FROM Steam_Data.steamdata 
GROUP BY Game_Title; # Group max purchases and hours by game title

# Finds the games with the most purchases but least amount of hours accross all players
SELECT Game_Title,
COUNT(CASE WHEN Behavior = "purchase" THEN Value END) AS max_purchases, # When Behavior = purchase, count it
SUM(CASE WHEN Behavior = 'play' THEN Value END) AS max_hours # When behavior = play, count it
FROM Steam_Data.steamdata 
GROUP BY Game_Title # Group max purchases and hours by game title
HAVING max_hours < 1 # Display hours played that are 0
ORDER BY max_purchases DESC; # Display highest amount of purchases first

# Used to validate the results above
SELECT Game_Title, Behavior, SUM(Value)
FROM Steam_Data.steamdata
WHERE Behavior = "play" AND Game_Title = "The Elder Scrolls V Skyrim"
GROUP BY Game_Title;

# Finds percentage of players with 0 hours of playtime per game, starting with the highest val

# Finds number of players who have 0 zero hours on a game as a %
SELECT Game_Title, count(Value) as noplay, count(*) * 100.0 / sum(count(*)) over() as percentage_of_noplay 
FROM Steam_Data.steamdata
WHERE Value = 0 # Hours played must be 0
GROUP BY Game_Title # Group by game title
ORDER BY noplay DESC; # Display highest amount of people with 0 hours first

# Finds total amount of players who purchase a game but never play them (Value = 0)
SELECT ROUND(COUNT(CASE WHEN Value = 0 THEN User_ID END) * 100/ COUNT(User_ID), 2)
FROM Steam_Data.steamdata;






