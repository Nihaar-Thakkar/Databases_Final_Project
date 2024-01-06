-- Retrieves the top 10 most popular genres based on title count in a given year
DELIMITER //
CREATE PROCEDURE GetTopGenresByYear(IN _year INT)
BEGIN
    SELECT genre, COUNT(*) AS titleCount
    FROM (
        SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(ti.genres, ',', numbers.n), ',', -1) AS genre
        FROM (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN TitleInfo ti
        ON CHAR_LENGTH(ti.genres) - CHAR_LENGTH(REPLACE(ti.genres, ',', '')) >= numbers.n - 1
        WHERE ti.startYear = _year OR ti.endYear = _year
    ) AS genres_split
    GROUP BY genre
    ORDER BY titleCount DESC
    LIMIT 10;
END //
DELIMITER ;