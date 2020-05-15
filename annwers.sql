-- Q1
-- 142 rows, 3 columns
-- target: 143 rows
SELECT FirstName, LastName, ClubName
FROM player
INNER JOIN playerteam -- Different for inner vs left
ON player.playerID = playerteam.playerID
INNER JOIN clubplayer
ON player.playerID = clubplayer.playerID
RIGHT JOIN club
ON clubplayer.ClubID = club.ClubID
WHERE clubplayer.FromDate < CURDATE() && (clubplayer.ToDate IS NULL || clubplayer.ToDate > CURDATE())
GROUP BY FirstName, LastName, ClubName
ORDER BY FirstName, LastName ASC

-- Q2
-- 73 rows, 1 column
SELECT  CONCAT(FIRSTNAME," ", LASTNAME)
FROM player
INNER JOIN playerteam -- Different for inner vs left
ON player.playerID = playerteam.playerID
INNER JOIN clubplayer
ON player.playerID = clubplayer.playerID
RIGHT JOIN club
ON clubplayer.ClubID = club.ClubID
WHERE Sex = 'F'
GROUP BY FirstName, LastName, ClubName
HAVING count(ClubName)>1
ORDER BY FirstName, LastName ASC
--

-- Q3
-- 15 rows

SELECT CONCAT(FirstName, " ", LastName)
FROM
player
WHERE playerID NOT IN (
SELECT player.PlayerID
FROM player
NATURAL JOIN playerteam -- Different for inner vs left
NATURAL JOIN game
NATURAL JOIN season
NATURAL JOIN competition
WHERE CompetitionType LIKE "%Mixed%"
GROUP BY PlayerID, CompetitionType
)

-- Q4
-- 2 rows
SELECT SeasonYear, COUNT(SeasonYear)
FROM game
NATURAL JOIN season
WHERE T1Score is NULL AND T2Score is NULL
GROUP BY SeasonYear

-- Q5
-- 4 rows
SELECT ClubName, SUM(Sex LIKE 'M') as Males, SUM(Sex LIKE 'F')as Females , ABS(SUM(Sex LIKE 'M') - SUM(Sex LIKE 'F')) as Difference
FROM club
NATURAL JOIN clubplayer
NATURAL JOIN player
WHERE clubplayer.FromDate < CURDATE() && (clubplayer.ToDate IS NULL || clubplayer.ToDate > CURDATE())
GROUP BY ClubName
HAVING Males != Females
ORDER BY Difference DESC


-- Q6--
-- 50 rows
SELECT FirstName, LastName, SEX
FROM player
NATURAL JOIN playerteam
NATURAL JOIN game
NATURAL JOIN season
GROUP BY FirstName, LastName, SEX
HAVING SUM(SeasonYear LIKE 2018) < SUM(SeasonYear LIKE 2017)

-- Q7
-- 5 rows
SELECT TeamName,
SUM(CASE
	WHEN Team1 = TeamID THEN T1Score
	WHEN Team2 = TeamID THEN T2Score
END) AS SCORE

FROM competition
NATURAL JOIN season
NATURAL JOIN game
INNER JOIN team
ON game.Team1 = team.TeamID OR game.Team2 = team.TeamID
WHERE CompetitionName LIKE "Bingham Trophy"
AND SeasonYear = 2017
GROUP BY TeamName
HAVING SCORE > 100
ORDER BY SCORE DESC


-- Q8
-- Arthur Dayley, 1183 days
SELECT CONCAT(FirstName, " ",  LastName), DATEDIFF('2020/04/30', FromDate) as Duration
FROM club
NATURAL JOIN clubplayer
NATURAL JOIN player
WHERE clubName LIKE "Melbourne City"
AND ToDate is NULL
GROUP BY FirstName, LastName, FromDate
ORDER BY Duration ASC
LIMIT 1

-- Q9
-- 20 rows, arthus top with 32
SELECT FirstName, LastName, COUNT(*) AS NumberOfForeign
FROM player
NATURAL JOIN playerteam
NATURAL JOIN clubplayer
JOIN team
ON playerteam.TeamID = team.TeamID
JOIN club
ON club.ClubID = clubplayer.ClubID
WHERE team.ClubID != club.ClubID
GROUP BY FirstName, LastName
ORDER BY NumberOfForeign DESC
LIMIT 20
