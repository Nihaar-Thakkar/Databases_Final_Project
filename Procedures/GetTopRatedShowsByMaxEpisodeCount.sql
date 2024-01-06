-- Retrieves the top 10 highest rated shows with episode count less than the specified number
DELIMITER //
CREATE PROCEDURE GetTopRatedShowsByMaxEpisodeCount(IN _maxEpisodes INT)
BEGIN
    SELECT ti.originalTitle, AVG(r.averageRating) AS avgRating, COUNT(e.tconst) AS episodeCount
    FROM Episodes e
    JOIN TitleInfo ti ON e.parentTConst = ti.tconst
    JOIN Ratings r ON e.parentTConst = r.tconst
    GROUP BY e.parentTConst
    HAVING COUNT(e.tconst) < _maxEpisodes
    ORDER BY avgRating DESC
    LIMIT 10;
END //
DELIMITER ;