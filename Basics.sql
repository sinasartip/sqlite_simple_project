-- SQLite
WITH PlayTrack AS (
SELECT tracks.TrackId AS 'Track ID', 
    playlist_track.PlaylistId AS 'Playlist ID'
FROM tracks
JOIN playlist_track
    ON tracks.TrackId=playlist_track.TrackId
)

SELECT * 
FROM PlayTrack;