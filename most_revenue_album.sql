-- SQLite
/* Which track generated the most revenue? which album? which genre?
 *  1- The invoice_item and tracks table keep track of sales and name of songs
 *  use a join to have the fina track total with names. 
 *  2- The track_sales can now be joined with the tracks table 
 *  and then the album table.
 *  3- Two albums A and B. Which generated the most revenue?
 *  A -> had 7 songs sold from it and B-> had 30 songs.
 *  Is this enough information?
 *  Are all song proces equal-> This could make the 7 songs worth more.
 *  All song prices are not equal
 */

WITH track_invoice AS(
    SELECT tracks.Name,
        invoice_items.UnitPrice, 
        invoice_items.Quantity 
    FROM invoice_items
    JOIN tracks
        ON tracks.TrackId = invoice_items.TrackId
),
track_sales AS(
    SELECT track_invoice.Name,
        COUNT(track_invoice.Quantity) AS quantity_sold
    FROM track_invoice
    GROUP BY track_invoice.Name
    ORDER BY quantity_sold DESC
),
album_sales AS(
SELECT tracks.AlbumId,
    COUNT(track_sales.quantity_sold) AS albums_sold
FROM track_sales
JOIN tracks
    ON tracks.Name = track_sales.Name 
GROUP BY track_sales.Name
ORDER BY albums_sold DESC)

SELECT albums.Title AS album,
    SUM(album_sales.albums_sold) AS songs_from_album_sold
FROM album_sales
JOIN albums
    ON albums.AlbumId = album_sales.AlbumId
GROUP BY albums.Title
ORDER BY albums.Title;



