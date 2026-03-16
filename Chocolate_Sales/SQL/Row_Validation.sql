check for duplicate order_id(primary key)
select [order_id], count(*) as quantity from [dbo].[chocolate_sales]
group by [order_id]
having count(*) >1

Top 5 products of each year
WITH base AS (
SELECT
YEAR([Date]) AS OrderYear,
[Product],
SUM([Amount]) AS totalAmount,
RANK() OVER (
PARTITION BY YEAR([Date])
ORDER BY SUM([Amount]) DESC
) AS SalesRank
FROM [dbo].[chocolate_sales]
GROUP BY YEAR([Date]), [Product]
)
SELECT
OrderYear,
Product,
totalAmount,
SalesRank
FROM base
WHERE SalesRank <= 5
ORDER BY OrderYear DESC, SalesRank ASC;

Total sales 
select [sales_year], sum([Amount]) as TotalAmount
from [dbo].[chocolate_sales]
group by [sales_year]
order by [sales_year] desc

total sales and orders by year/month for trends
select [sales_year], [sales_month], sum([Amount]) as TotalAmount, count(order_id) as totalorders 
from [dbo].[chocolate_sales]
group by [sales_year], [sales_month]
order by [sales_year] desc, [sales_month] asc

total sales by year/growth over previous year
with base as(select [sales_year] as SalesYear, sum([Amount]) as CurrentYearSales
from [dbo].[chocolate_sales]
group by [sales_year]
), Comparison as(
select *,
lag(CurrentYearSales) over (order by Salesyear) as PriorYearSales
from base
)
select SalesYear, currentyearsales, ((((currentyearsales-prioryearsales)*1.0)/prioryearsales)*100) as Growth
from Comparison
order by salesyear desc


Sales person orders/amount sold by year top 5
with base as(select [sales_year], [Sales Person], sum([Amount]) as TotalAmount, count(order_id) as totalorders, 
RANK() OVER (
PARTITION BY [Sales_year]
ORDER BY SUM([Amount]) DESC
) AS SalesRank
from [dbo].[chocolate_sales]
group by [sales_year], [Sales Person]
)

select *, (totalamount/totalorders) as AverageOrderValue from base
where SalesRank <=5
order by [sales_year] desc

Order total and amount sold by country

select Country, sum([amount]) as TotalAmount, Count(*) as TotalOrders 
from [dbo].[chocolate_sales]
group by Country
order by TotalAmount desc

top 5 products sold/orders by country

with base as(select country, sum(amount) as TotalSold, count(*) as ProductOrders, product, sum([Boxes Shipped]) as Boxes,
RANK() OVER (
PARTITION BY [Country]
ORDER BY SUM([Amount]) DESC
) AS SalesRank
from [dbo].[chocolate_sales]
group by country, product
)
select * from base
where SalesRank <=5
order by country

