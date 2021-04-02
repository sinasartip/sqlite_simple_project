-- Which countries have the highest sales revenue? What percent of total revenue does each country make up?
-- CustomerId and Country are in the customers table. 
-- CustomerId and Total are found in invoice items.

SELECT customers.Country, 
    SUM(invoices.Total) AS Revenue
FROM invoices
JOIN customers
    ON customers.CustomerId = invoices.CustomerId
GROUP BY Country
ORDER BY Revenue DESC;
