DELIMITER //
DROP PROCEDURE IF EXISTS GenericShowRecommendation;
CREATE PROCEDURE GenericShowRecommendation(IN P_YEAR INT)
BEGIN

    DECLARE LANGNAME VARCHAR(50) DEFAULT "";
    DECLARE FINISHED INTEGER DEFAULT 0;
    DECLARE COUNTER INT DEFAULT 0;
    DECLARE CURRENT_RECORD CURSOR FOR
        SELECT DISTINCT(TW.genres)
        FROM TitleInfo TW;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FINISHED = 1;
    OPEN CURRENT_RECORD;

    main_loop: LOOP
        FETCH CURRENT_RECORD INTO LANGNAME;

        IF FINISHED = 1 OR COUNTER >= 20 THEN
            LEAVE main_loop;
        END IF;

        SELECT t2.originalTitle, rt1.averageRating, t2.genres FROM (
            SELECT ay.*
            FROM (
                SELECT t1.tconst, t1.originalTitle, t1.startYear, t1.type, t1.genres
                FROM TitleInfo t1
                WHERE t1.startYear = P_YEAR AND t1.type = 'tvSeries' AND INSTR(LOWER(genres), LOWER(LANGNAME)) > 0
            ) ay
        ) t2
        INNER JOIN (
            SELECT rt.averageRating, rt.tconst
            FROM Ratings rt
        ) rt1 ON rt1.tconst = t2.tconst
        ORDER BY rt1.averageRating DESC LIMIT 20;

        SET COUNTER = COUNTER + 1;
        SET FINISHED = 0;
    END LOOP;

    CLOSE CURRENT_RECORD;
END //
DELIMITER ;
