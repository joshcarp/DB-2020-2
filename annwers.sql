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

