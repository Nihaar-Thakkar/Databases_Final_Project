-- Retrieves total sales for a game along with publisher and release date
DELIMITER //
CREATE PROCEDURE GetTotalSalesPublisherReleaseForGame(IN _game NVARCHAR(500), IN _platform VARCHAR(50))
BEGIN
    SELECT gs.game, gs.totalSales, gs.publisher, gs.releaseDate
    FROM GameSales gs
    WHERE gs.game = _game AND gs.platform = _platform;
END //
DELIMITER ;
