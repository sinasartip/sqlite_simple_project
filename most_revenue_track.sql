-- SQLite
/* Which track generated the most revenue? which album? which genre?
 *  1- The invoice_item and tracks table keep track of sales and name of songs
 *  use a join to have the fina track total with names. 
 *  
 */

WITH track_invoice AS(
SELECT tracks.Name,
    invoice_items.UnitPrice, 
    invoice_items.Quantity 
FROM invoice_items
JOIN tracks
    ON tracks.TrackId = invoice_items.TrackId
)

SELECT track_invoice.Name,
    COUNT(Quantity) AS quantity_sold
FROM track_invoice
GROUP BY track_invoice.Name
ORDER BY quantity_sold DESC;
