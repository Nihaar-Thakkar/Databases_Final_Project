-- Retrieves all games on a given platform with a VGScore higher than the specified score
DELIMITER //
CREATE PROCEDURE GetGamesByPlatformVGScore(IN _platform VARCHAR(50), IN _minVGScore FLOAT)
BEGIN
    SELECT game, vgscore
    FROM GameSales
    WHERE platform = _platform AND vgscore > _minVGScore;
END //
DELIMITER ;