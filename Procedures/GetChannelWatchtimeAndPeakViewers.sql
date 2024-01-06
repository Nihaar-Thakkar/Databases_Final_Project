-- Retrieves channel watch time and peak viewers
DELIMITER //
CREATE PROCEDURE GetChannelWatchtimeAndPeakViewers(IN _channel VARCHAR(70))
BEGIN
    SELECT channel, watchTime, peakViewers
    FROM TwitchWatched
    WHERE channel = _channel;
END //
DELIMITER ;

