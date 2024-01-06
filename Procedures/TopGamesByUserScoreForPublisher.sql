DELIMITER //
CREATE PROCEDURE TopGamesByUserScoreForPublisher(
    IN publisherName VARCHAR(100)
)
BEGIN
    SELECT game, userscore
    FROM GameSales
    WHERE publisher = publisherName
    ORDER BY userscore DESC
    LIMIT 5;
END //
DELIMITER ;
