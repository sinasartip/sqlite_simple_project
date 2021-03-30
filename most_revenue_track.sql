-- SQLite
/* Which track generated the most revenue? which album? which genre?
 *  1- The invoice_item and tracks table keep track of sales and name of songs
 *  use a join to have the final track total with names.
 *  2- The Quantity sold can be multiplied by track price.
 *  3- Since there are several tracks with equal revenue we show a table of max  values.  
 */

WITH track_invoice AS(
SELECT tracks.Name,
    tracks.TrackId,
    invoice_items.UnitPrice, 
    invoice_items.Quantity 
FROM invoice_items
JOIN tracks
    ON tracks.TrackId = invoice_items.TrackId
),
sales_of_track AS(
SELECT track_invoice.TrackId,
    track_invoice.Name,
    COUNT(Quantity) AS quantity_sold,
    track_invoice.UnitPrice,
    track_invoice.UnitPrice*COUNT(Quantity) AS total_revenue
FROM track_invoice
GROUP BY track_invoice.TrackId
),
max_revenue AS(
SELECT MAX(sales_of_track.total_revenue) 
FROM sales_of_track
)

SELECT sales_of_track.Name,
    sales_of_track.total_revenue
FROM sales_of_track
WHERE sales_of_track.total_revenue = (SELECT * FROM max_revenue);