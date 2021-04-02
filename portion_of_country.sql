-- What percent of total revenue does each country make up?
-- CustomerId and Country are in the customers table. 
-- CustomerId and Total are found in invoice items.
With total_revenue AS(
SELECT SUM(invoices.Total) 
FROM invoices
),
revenue_by_country AS(
SELECT customers.Country, 
    SUM(invoices.Total) AS Revenue,
    (SELECT * FROM total_revenue) AS Total_Revenue
FROM invoices
JOIN customers
    ON customers.CustomerId = invoices.CustomerId
GROUP BY Country
ORDER BY Revenue DESC
)

SELECT Country, 
    Revenue,
    Total_Revenue,
    ROUND((Revenue/Total_Revenue)*100,2) AS 'Percent_Of_Total'
FROM revenue_by_country;