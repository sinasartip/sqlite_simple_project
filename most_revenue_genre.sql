-- SQLite
/* Which track generated the most revenue? which album? which genre?
 *  1- The invoice_item and tracks table keep track of sales and name of songs
 *  use a join to have the final track total with names. 
 *  2- The track_sales can now be joined with the tracks table 
 *  and then the genre table.
 *  3- Two genre A and B. Which generated the most revenue?
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
ungrouped_genre_sales AS(
SELECT tracks.GenreId,
    COUNT(track_sales.quantity_sold) AS numOf_songSale_inGenre,
    SUM(tracks.UnitPrice) AS revenue_from_sale
FROM track_sales
JOIN tracks
    ON tracks.Name = track_sales.Name 
GROUP BY track_sales.Name
ORDER BY GenreId DESC
)

SELECT genres.Name AS genre,
    SUM(ungrouped_genre_sales.numOf_songSale_inGenre) AS songs_from_genre_sold,
    SUM(ungrouped_genre_sales.revenue_from_sale) AS revenue_from_genre
FROM ungrouped_genre_sales
JOIN genres
    ON genres.GenreId = ungrouped_genre_sales.GenreId
GROUP BY genres.Name
ORDER BY revenue_from_genre DESC;



