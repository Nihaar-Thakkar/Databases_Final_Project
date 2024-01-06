-- Retrieves the top 10 shows with the highest episode count in a given year
DELIMITER //
CREATE PROCEDURE GetTopShowsByEpisodeCountInYear(IN _year INT)
BEGIN
    SELECT ti.originalTitle, COUNT(e.tconst) AS episodeCount
    FROM Episodes e
    JOIN TitleInfo ti ON e.parentTConst = ti.tconst
    WHERE ti.startYear = _year OR ti.endYear = _year
    GROUP BY e.parentTConst
    ORDER BY episodeCount DESC
    LIMIT 10;
END //
DELIMITER ;