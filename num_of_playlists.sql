--SQLite
/*  Which tracks appeared in the most playlists? 
 *  1- Select tracks and playlists from playlist_track
 *  2- Organize the tracks so to see what playlists the track is on visually
 *  3- Count the instances of playlists grouped by track
 *  4- SELECT song name and number of instances Ordered Desc
 *  5- only show highest playlist instances
    how many playlist did they appear in?*/

WITH play_track_name AS(
SELECT COUNT(PlaylistId) AS num_of_playlists, tracks.TrackId AS TrackId,
    tracks.Name  
FROM playlist_track
JOIN tracks
    ON tracks.TrackId = playlist_track.TrackId
GROUP BY tracks.TrackId
)

SELECT play_track_name.Name AS song,
    play_track_name.num_of_playlists AS 'playlists seen in'
FROM play_track_name
WHERE play_track_name.num_of_playlists = 
    (SELECT MAX(play_track_name.num_of_playlists) 
        FROM play_track_name); 