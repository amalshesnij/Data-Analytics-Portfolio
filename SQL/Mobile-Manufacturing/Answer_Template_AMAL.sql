--SQL Advance Case Study


--Q1--BEGIN 
	
SELECT DISTINCT loc.[State]
FROM FACT_TRANSACTIONS ft
JOIN DIM_LOCATION Loc ON ft.IDLocation = Loc.IDLocation
WHERE YEAR(ft.Date) >= 2005;




--Q1--END

--Q2--BEGIN
	
SELECT TOP 1 loc.[State],COUNT (*) AS Total_Sales
FROM FACT_TRANSACTIONS ft
JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
JOIN DIM_MANUFACTURER man ON mo.IDManufacturer = man.IDManufacturer
JOIN DIM_LOCATION loc ON ft.IDLocation = loc.IDLocation
WHERE man.Manufacturer_Name = 'Samsung'
AND loc.Country = 'US'
GROUP BY loc.[State]
ORDER BY Total_Sales DESC;








--Q2--END

--Q3--BEGIN      
	
SELECT mo.Model_Name,
       loc.ZipCode,
       loc.[State],
       COUNT(*) AS No_of_Transactions
FROM FACT_TRANSACTIONS ft
JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
JOIN DIM_LOCATION loc ON ft.IDLocation = loc.IDLocation
GROUP BY mo.Model_Name, loc.ZipCode, loc.[State]
ORDER BY mo.Model_Name, loc.[State];









--Q3--END

--Q4--BEGIN


SELECT TOP 1 Model_Name, Unit_price
FROM DIM_MODEL
ORDER BY Unit_price ASC;




--Q4--END

--Q5--BEGIN



SELECT man.Manufacturer_Name,
       mo.Model_Name,
       AVG(ft.TotalPrice) AS Avg_Price
FROM FACT_TRANSACTIONS ft
JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
JOIN DIM_MANUFACTURER man ON mo.IDManufacturer = man.IDManufacturer
WHERE man.IDManufacturer IN (
    SELECT TOP 5 mo2.IDManufacturer
    FROM FACT_TRANSACTIONS ft2
    JOIN DIM_MODEL mo2 ON ft2.IDModel = mo2.IDModel
    GROUP BY mo2.IDManufacturer
    ORDER BY SUM(ft2.Quantity) DESC
)
GROUP BY man.Manufacturer_Name, mo.Model_Name
ORDER BY Avg_Price ASC;










--Q5--END

--Q6--BEGIN

SELECT c.Customer_Name,
       AVG(ft.TotalPrice) AS Avg_Spent
FROM FACT_TRANSACTIONS ft
JOIN DIM_CUSTOMER c ON ft.IDCustomer = c.IDCustomer
WHERE YEAR(ft.Date) = 2009
GROUP BY c.Customer_Name
HAVING AVG(ft.TotalPrice) > 500
ORDER BY Avg_Spent DESC;










--Q6--END
	
--Q7--BEGIN  
	
	
SELECT Model_Name FROM (
    SELECT TOP 5 mo.Model_Name, SUM(ft.Quantity) AS TotalQty
    FROM FACT_TRANSACTIONS ft
    JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
    WHERE YEAR(ft.Date) = 2008
    GROUP BY mo.Model_Name
    ORDER BY TotalQty DESC
) AS Top2008

INTERSECT

SELECT Model_Name FROM (
    SELECT TOP 5 mo.Model_Name, SUM(ft.Quantity) AS TotalQty
    FROM FACT_TRANSACTIONS ft
    JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
    WHERE YEAR(ft.Date) = 2009
    GROUP BY mo.Model_Name
    ORDER BY TotalQty DESC
) AS Top2009

INTERSECT

SELECT Model_Name FROM (
    SELECT TOP 5 mo.Model_Name, SUM(ft.Quantity) AS TotalQty
    FROM FACT_TRANSACTIONS ft
    JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
    WHERE YEAR(ft.Date) = 2010
    GROUP BY mo.Model_Name
    ORDER BY TotalQty DESC
) AS Top2010;















--Q7--END	
--Q8--BEGIN


SELECT Year, Manufacturer_Name, TotalSales
FROM (
    SELECT 
        YEAR(ft.Date) AS Year,
        man.Manufacturer_Name,
        SUM(ft.TotalPrice) AS TotalSales,
        ROW_NUMBER() OVER (
            PARTITION BY YEAR(ft.Date) 
            ORDER BY SUM(ft.TotalPrice) DESC
        ) AS Rnk
    FROM FACT_TRANSACTIONS ft
    JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
    JOIN DIM_MANUFACTURER man ON mo.IDManufacturer = man.IDManufacturer
    WHERE YEAR(ft.Date) IN (2009, 2010)
    GROUP BY YEAR(ft.Date), man.Manufacturer_Name
) AS Ranked
WHERE Rnk = 2;















--Q8--END
--Q9--BEGIN
	


	SELECT DISTINCT man.Manufacturer_Name
FROM FACT_TRANSACTIONS ft
JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
JOIN DIM_MANUFACTURER man ON mo.IDManufacturer = man.IDManufacturer
WHERE YEAR(ft.Date) = 2010

EXCEPT

SELECT DISTINCT man.Manufacturer_Name
FROM FACT_TRANSACTIONS ft
JOIN DIM_MODEL mo ON ft.IDModel = mo.IDModel
JOIN DIM_MANUFACTURER man ON mo.IDManufacturer = man.IDManufacturer
WHERE YEAR(ft.Date) = 2009;














--Q9--END

--Q10--BEGIN
	



	WITH Top100 AS (
    SELECT TOP 100 IDCustomer, SUM(TotalPrice) AS TotalSpend
    FROM FACT_TRANSACTIONS
    GROUP BY IDCustomer
    ORDER BY TotalSpend DESC
),
YearlyStats AS (
    SELECT 
        c.Customer_Name,
        YEAR(ft.Date) AS [Year],
        AVG(ft.TotalPrice) AS Avg_Spend,
        AVG(ft.Quantity) AS Avg_Quantity,
        SUM(ft.TotalPrice) AS Total_Spend
    FROM FACT_TRANSACTIONS ft
    JOIN DIM_CUSTOMER c ON ft.IDCustomer = c.IDCustomer
    WHERE ft.IDCustomer IN (SELECT IDCustomer FROM Top100)
    GROUP BY c.Customer_Name, YEAR(ft.Date)
)
SELECT 
    Customer_Name,
    [Year],
    Avg_Spend,
    Avg_Quantity,
    Total_Spend,
    LAG(Total_Spend) OVER (
        PARTITION BY Customer_Name 
        ORDER BY [Year]
    ) AS Prev_Year_Spend,
    ROUND(
        (Total_Spend - LAG(Total_Spend) OVER (
            PARTITION BY Customer_Name ORDER BY [Year]
        )) * 100.0 / NULLIF(LAG(Total_Spend) OVER (
            PARTITION BY Customer_Name ORDER BY [Year]
        ), 0), 2
    ) AS Pct_Change
FROM YearlyStats
ORDER BY Customer_Name, [Year];














--Q10--END
	