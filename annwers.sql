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

-- 142 rows, 3 columns
-- target: 143 rows
