/*Get tv Series recommendations based on genre, year input for all genres of top 10 ratings*/

DELIMITER //
DROP PROCEDURE IF EXISTS SpecificShowRecommendation;
CREATE PROCEDURE SpecificShowRecommendation(IN P_YEAR INT, IN P_GENRE VARCHAR(20))
  BEGIN
    select t2.originalTitle,rt1.averageRating,t2.genres from 
      (select t1.tconst tconst, t1.originalTitle, t1.startYear, t1.type, t1.genres from TitleInfo t1 where t1.startYear = P_YEAR AND t1.type = 'tvSeries'
                           AND  INSTR(LOWER(genres),LOWER(P_GENRE) ) > 0)t2
      INNER JOIN 
      (SELECT rt.averageRating, rt.tconst from Ratings rt)rt1
      on rt1.tconst = t2.tconst
      ORDER by rt1.averageRating desc limit 10;
  END //
  DELIMITER ;