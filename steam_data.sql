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
WHERE Behavior = "play" # Only adds rows with "play" as the behavior
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
WHERE Game_Title LIKE "Call of Duty%";

# Which Call of Duty experience has the most amount of hours put into it? 
SELECT Game_Title, Behavior, SUM(Value) as max_cod_hours
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "play"
GROUP BY Game_Title
ORDER BY SUM(Value) DESC;

# Which Call of Duty experience has the least amount of hours put into it? 
SELECT Game_Title, Behavior, SUM(Value) as max_cod_hours
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "play"
GROUP BY Game_Title
ORDER BY SUM(Value) ASC;

# Which Call of Duty experience has the most amount of purchases?
SELECT Game_Title, COUNT(Behavior) AS max_cod_purchases
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "purchase"
GROUP BY Game_Title
ORDER BY COUNT(Behavior) DESC;

# Which Call of Duty experience has the least amount of purchases?
SELECT Game_Title, COUNT(Behavior) AS max_cod_purchases
FROM Steam_Data.steamdata
WHERE Game_Title LIKE "Call of Duty%" AND Behavior = "purchase"
GROUP BY Game_Title
ORDER BY COUNT(Behavior) ASC;