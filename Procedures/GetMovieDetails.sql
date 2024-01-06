CREATE PROCEDURE GetMovieDetails(IN m_title VARCHAR(600))
BEGIN
  SELECT 
    ti.originalTitle, 
    ti.startYear,
    ti.runtime,
    r.averageRating, 
    r.numVotes
  FROM 
    TitleInfo AS ti 
  INNER JOIN 
    Ratings AS r ON r.tconst = ti.tconst
  WHERE 
    ti.originalTitle = m_title
    AND
    ti.type = 'movie';
END$$
