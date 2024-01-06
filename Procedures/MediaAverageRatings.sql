DROP PROCEDURE IF EXISTS MediaAverageRatings;
DELIMITER //
CREATE PROCEDURE MediaAverageRatings (year INT)
BEGIN
    SELECT type, AVG(averageRating) AS avgRating, COUNT(DISTINCT(Ratings.tconst)) AS numberEntries, AVG(runTime) AS avgRunTime
    FROM TitleInfo JOIN Ratings ON TitleInfo.tconst = Ratings.tconst
    WHERE startYear = year
    GROUP BY type;
END //
DELIMITER ;